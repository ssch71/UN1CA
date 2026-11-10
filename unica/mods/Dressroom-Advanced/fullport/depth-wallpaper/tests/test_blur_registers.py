#!/usr/bin/env python3
"""Protect caller null/Throwable liveness in generated blur hooks."""
import importlib.util
import re
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('depth', Path(__file__).parents[1] / 'generate.py')
depth = importlib.util.module_from_spec(spec)
spec.loader.exec_module(depth)


class BlurRegistersTest(unittest.TestCase):
    def test_live_null_and_exception_regions_are_preserved(self):
        original = '''.class public Lfixture/Container;
.super Landroid/view/View;
.method public blur()V
    .locals 2
    const/4 v1, 0x0
    :try_start
    invoke-virtual {p0, v1}, Landroid/view/View;->semSetBlurInfo(Landroid/view/SemBlurInfo;)V
    throw v1
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    :catch
    move-exception v0
    invoke-static {v1}, Lfixture/Logger;->log(Ljava/lang/Throwable;)V
    return-void
.end method
'''
        result = depth.blur_submissions(original, 1, 'fixture')
        caller, helper = result.split('\n.method private static nativeDepthSetBlurInfo', 1)
        restored = caller.replace(
            'invoke-static {p0, v1}, Lfixture/Container;->nativeDepthSetBlurInfo(Landroid/view/View;Landroid/view/SemBlurInfo;)V',
            'invoke-virtual {p0, v1}, Landroid/view/View;->semSetBlurInfo(Landroid/view/SemBlurInfo;)V')
        self.assertEqual(original, restored)
        self.assertIn('    .locals 1', helper)
        self.assertIn('    move-result-object v0', helper)
        self.assertNotRegex(helper, r'(move-result-object|check-cast) p[01]')
        with self.assertRaises(ValueError):
            depth.blur_submissions(result, 1, 'fixture')
        with self.assertRaises(ValueError):
            depth.blur_submissions(original, 2, 'fixture')


if __name__ == '__main__':
    unittest.main()
