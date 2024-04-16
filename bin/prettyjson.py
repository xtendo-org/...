#!/usr/bin/env python

import sys
import json

d = json.load(sys.stdin)

# json.dump(d, sys.stdout, sort_keys=True, indent=2)
json.dump(d, sys.stdout, indent=2, ensure_ascii=False)
