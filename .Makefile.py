#!/usr/bin/env python3
import os

class TargetList:
    zsh  = ['zshrc']
    vim  = ['vim', 'vimrc', 'gvimrc']
    X    = ['mlterm', 'wmii', 'xsession', 'Xresources']


def make_symlink(fname):
    """ """
    src = os.getcwd() + '/' + fname
    dst = os.environ['HOME'] + '/.' + fname
    try:
        os.remove(dst)
    except FileNotFoundError:
        pass
    print(src, '->', dst)
    os.symlink(src, dst)


if __name__ == '__main__':
    import sys
    target_list = TargetList()
    tl = []
    for target in sys.argv[1:]:
        tl += getattr(target_list, target)
    for target in tl:
        make_symlink(target)
