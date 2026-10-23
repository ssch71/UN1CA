#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (c) 2026 ssch71
"""Add the <hal> entries (matched by name and format) that the target's stock
framework manifest declares but the source manifest lacks, so an older vendor
still finds the system HALs it expects. Source entries are kept as is."""
import sys
import xml.etree.ElementTree as ET

src_path, tgt_path = sys.argv[1], sys.argv[2]
src_tree = ET.parse(src_path)
src = src_tree.getroot()
tgt = ET.parse(tgt_path).getroot()

have = {(h.findtext('name'), h.get('format', 'hidl')) for h in src.findall('hal')}
added = []
for hal in tgt.findall('hal'):
    key = (hal.findtext('name'), hal.get('format', 'hidl'))
    if key[0] and key not in have:
        src.append(hal)
        have.add(key)
        added.append('%s (%s)' % key)

ET.indent(src_tree, space='    ')
src_tree.write(src_path, encoding='utf-8', xml_declaration=False)
for name in added:
    print(name)
