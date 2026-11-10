#!/usr/bin/env python3
"""Regression for both Android rendering entries and balanced nested depth layers."""
import importlib.util
from pathlib import Path
import re
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).parents[1]
spec = importlib.util.spec_from_file_location('depth', ROOT / 'generate.py')
depth = importlib.util.module_from_spec(spec)
spec.loader.exec_module(depth)


class DepthDrawPathsTest(unittest.TestCase):
    def test_both_render_entries_have_balanced_success_and_failure_paths(self):
        original = '.class public Lfixture/Clock;\n.super Landroid/widget/FrameLayout;\n'
        generated = depth.depth_draw_methods(original)
        for access, name in [('public', 'draw'), ('protected', 'dispatchDraw')]:
            body = re.search(r'^\.method ' + access + ' ' + name
                             + r'\(Landroid/graphics/Canvas;\)V\n(.*?)^\.end method',
                             generated, re.M | re.S)[1]
            self.assertEqual(body.count('->beforeDraw('), 1)
            self.assertEqual(body.count('->afterDraw('), 2)
            self.assertEqual(body.count('->drawn('), 1)
            self.assertIn('->' + name + '(Landroid/graphics/Canvas;)V', body)
            self.assertRegex(body, r':try_start_native_depth\n    invoke-super .*\n    :try_end_native_depth')
            self.assertIn('.catchall {:try_start_native_depth .. :try_end_native_depth} :catch_native_depth', body)
            self.assertRegex(body, r':catch_native_depth\n    move-exception v1\n    invoke-static .*afterDraw.*\n    throw v1')
        self.assertTrue(generated.startswith(original))
        with self.assertRaises(ValueError):
            depth.depth_draw_methods(generated)
        with self.assertRaises(ValueError):
            depth.depth_draw_methods(original + '.method protected dispatchDraw(Landroid/graphics/Canvas;)V\n.end method\n')

    def test_actual_java_scope_methods_restore_once_and_handle_exception(self):
        # Compile the real scope methods with a minimal Canvas/View double. This
        # tests nested draw -> dispatchDraw and direct dispatchDraw entry behavior
        # without copying/reimplementing the production scope logic in the test.
        source = (ROOT / 'java/dev/denver/dressroomadvanced/DepthEffects.java').read_text()
        methods = source[source.index('    static int beforeDraw('):source.index('    private static void drawMask(')]
        java = '''import java.util.*;
public final class DepthScopeProbe {
 static final Map<View,Entry> entries = new HashMap<>();
 static final ThreadLocal<Boolean> drawingClock = ThreadLocal.withInitial(()->false);
 static boolean sourcePending, maskThrows;
 static int masks;
 static class View {}
 static class Entry { Object mask=new Object(); boolean enabled=true,nodeClip,editor; }
 static class Canvas {
  int saves,restores;
  int saveLayer(Object bounds,Object paint){return ++saves;}
  void restoreToCount(int saved){if(saved!=1)throw new AssertionError("Wrong save token");restores++;}
 }
 static Entry inheritedSubject(View view){return null;}
 static boolean subjectSuppressed(View view,Entry entry){return false;}
 static void drawMask(Canvas canvas,View view,Entry entry){masks++;if(maskThrows)throw new IllegalStateException("mask");}
''' + methods + '''
 static void check(boolean value){if(!value)throw new AssertionError();}
 public static void main(String[] args){
  View clock=new View();entries.put(clock,new Entry());
  Canvas canvas=new Canvas();
  int outer=beforeDraw(clock,canvas),nested=beforeDraw(clock,canvas);
  check(outer==1&&nested==-1&&canvas.saves==1);
  afterDraw(clock,canvas,nested);
  check(drawingClock.get()&&canvas.restores==0&&masks==0);
  afterDraw(clock,canvas,outer);
  check(!drawingClock.get()&&canvas.restores==1&&masks==1);
  canvas=new Canvas();int direct=beforeDraw(clock,canvas);
  afterDraw(clock,canvas,direct);
  check(canvas.saves==1&&canvas.restores==1&&masks==2);
  canvas=new Canvas();int failed=beforeDraw(clock,canvas);maskThrows=true;
  try{afterDraw(clock,canvas,failed);throw new AssertionError();}
  catch(IllegalStateException expected){}
  check(!drawingClock.get()&&canvas.restores==1);
  entries.clear();canvas=new Canvas();int absent=beforeDraw(clock,canvas);
  afterDraw(clock,canvas,absent);check(absent==-1&&canvas.saves==0&&canvas.restores==0);
  System.out.println("Depth nested/direct/exception draw scopes passed");
 }
}
'''
        with tempfile.TemporaryDirectory(prefix='dressroom-depth-scope-test-') as directory:
            path = Path(directory)
            (path / 'DepthScopeProbe.java').write_text(java)
            subprocess.run(['javac', str(path / 'DepthScopeProbe.java')], check=True)
            subprocess.run(['java', '-cp', directory, 'DepthScopeProbe'], check=True)


if __name__ == '__main__':
    unittest.main()
