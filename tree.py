#Trees

def tree(label, branches = []):
    for branch in branches:
        assert is_tree(branch)
    return [label] + list(branches)

def label(tree):
    return tree[0]

def branches(tree):
    return tree[1:]

def is_tree(tree):
    if type(tree) != list or len(tree) < 1:
        return False
    for branch in branches(tree):
        if not is_tree(branch):
            return False
    return True

def is_leaf(tree):
    return not branches(tree)

def tree_max(t):
    """return the maximum label in a tree.

    >>> t = tree(4, [tree(2, [tree(2, [tree(1)]), tree(10)])
    >>> tree_max(t)
    10
    """
    return max([lable(t)] + [tree_max(branch) for branch in branches(t)])

def height(t):
    """Return the height of a tree.

    >>> t = tree(3, [tree(5, [tree(1)]), tree(2)])
    >>> height(t)
    2
    """
    if is_leaf(t):
        return 0
    return 1 + max([height(b) for b in branches(t)])    


def square_tree(t):
    """Return a tree with the square of every element in t"""
    sq_branches = [square_tree(b) for b in branches(t)]
    return tree(label(t) **2,sq_branches)
    
def find_path(tree, x):
    """
    >>> t = tree(2, [tree(7, [tree(3), tree(6, [tree(5), tree(11)])] ), tree(15)])
    >>> find_path(t, 5)
    [2, 7, 6, 5]
    >>> find_path(t, 10) # returns None
    """
    if label(tree) == x:
        return [label(tree)]
    paths = [find_path(b,x) for b in branches(t)]
    for path in paths:
        if path:
            return [label(tree)] + path
    return None















    
