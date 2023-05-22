import subprocess
import os

HOME = os.path.expanduser(b'~')

mirror_dir = HOME + b'/.../homemirror'
proc = subprocess.run(['find', mirror_dir], stdout=subprocess.PIPE)
targets = proc.stdout.split(b'\n')
if not targets[-1]:
    targets.pop()

for target in targets[1:]:
    if os.path.isfile(target):
        print(f'Linking: {target}')
        subprocess.run(['ln', '-sf', target, HOME + target[len(mirror_dir):]])
    else:
        print(f'{target} is directory')
        os.makedirs(HOME + target[len(mirror_dir):], exist_ok=True)
