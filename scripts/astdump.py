import ast
import sys
import json

def make_json(y):
    """
    
    Arguments:
    - `y`:
    """
    xs = y or []
    print xs
    try:
        return [str(x) for x in xs]
    except Exception as e:
        return ""
    
class v(ast.NodeVisitor):
    def generic_visit(self, node, spacing=""):
        return {"node":str(type(node).__name__),
                "line":node.lineno if hasattr(node, "lineno") else "",
                "col_offset":node.col_offset if hasattr(node, "lineno") else "",
                "fields":[dict((x,str(y)) for x,y in ast.iter_fields(node))],
                "children":[self.generic_visit(x, spacing + "  ") for x in ast.iter_child_nodes(node)]}

print json.dumps(v().visit(ast.parse(sys.stdin.read())), indent=2)
