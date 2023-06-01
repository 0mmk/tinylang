typedef enum { typeCon, typeId, typeOpr, typeStr } nodeEnum;

typedef struct {
    int value;
} ConstantNode;

typedef struct {
    int i;
} IDNode;

typedef struct {
    char* str;
} StringNode;

typedef struct {
    int oper;
    int nops;
    struct NodeStruct *op[1];
} OperatorNode;

typedef struct NodeStruct {
    nodeEnum type;

    union {
        ConstantNode con;
        IDNode id;
        OperatorNode opr;
        StringNode snode;
    };
} Node;

extern int sym[256];
