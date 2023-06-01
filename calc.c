#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include "calc.h"
#include "y.tab.h"

int fn_id_i;
struct NodeStruct fn_body;

typedef struct fn {
    bool is_set;
    struct NodeStruct body;
} fn;

struct fn functions[256];

void deepCopyNodeStruct(struct NodeStruct* dest, struct NodeStruct* src) {
    dest->type = src->type;
    switch (src->type) {
        case typeCon:
            dest->con.value = src->con.value;
            break;
        case typeId:
            dest->id.i = src->id.i;
            break;
        case typeStr:
            dest->snode.str = malloc(sizeof(char) * (strlen(src->snode.str) + 1));
            strcpy(dest->snode.str, src->snode.str);
            break;
        case typeOpr:
            dest->opr.oper = src->opr.oper;
            dest->opr.nops = src->opr.nops;
            for (int i = 0; i < src->opr.nops; i++) {
                dest->opr.op[i] = malloc(sizeof(struct NodeStruct));
                deepCopyNodeStruct(dest->opr.op[i], src->opr.op[i]);
            }
            break;
    }
}

int strsize(char *str) {
    int i = 1;
    while(str[i++] != '"') { }
    return i;
}

int evaluate(Node* p) {
    struct NodeStruct* fn_body = NULL;

    if (!p)
        return 0;
    switch (p->type) {
        case typeCon:
            return p->con.value;
        case typeId:
            return sym[p->id.i];
        case typeStr:
            return 0;
        case typeOpr:
            switch (p->opr.oper) {
                case FNCALL:
                    if (functions[p->opr.op[0]->id.i].is_set) {
                        return evaluate(&functions[p->opr.op[0]->id.i].body);
                    } else {
                        fprintf(stderr, "Error: function %c not found\n", p->opr.op[0]->id.i);
                        return 0;
                    }
                case FNDEF:
                    deepCopyNodeStruct(&functions[p->opr.op[0]->id.i].body, p->opr.op[1]);
                    functions[p->opr.op[0]->id.i].is_set = true;
                    return 0;
                case WHILE:
                    while (evaluate(p->opr.op[0]))
                        evaluate(p->opr.op[1]);
                    return 0;
                case IF:
                    if (evaluate(p->opr.op[0]))
                        evaluate(p->opr.op[1]);
                    return 0;
                case PRINT:
                    if (p->opr.op[0]->type == typeStr) {
                        printf("%s\n", p->opr.op[0]->snode.str);
                        return 0;
                    }
                    printf("%d\n", evaluate(p->opr.op[0]));
                    return 0;
                case COMB:
                    evaluate(p->opr.op[0]);
                    return evaluate(p->opr.op[1]);
                case SET:
                    return sym[p->opr.op[0]->id.i] = evaluate(p->opr.op[1]);
                case ADD:
                    return evaluate(p->opr.op[0]) + evaluate(p->opr.op[1]);
                case SUB:
                    return evaluate(p->opr.op[0]) - evaluate(p->opr.op[1]);
                case MUL:
                    return evaluate(p->opr.op[0]) * evaluate(p->opr.op[1]);
                case DIV:
                    return evaluate(p->opr.op[0]) / evaluate(p->opr.op[1]);
                case LT:
                    return evaluate(p->opr.op[0]) < evaluate(p->opr.op[1]);
                case GT:
                    return evaluate(p->opr.op[0]) > evaluate(p->opr.op[1]);
                case EQ:
                    return evaluate(p->opr.op[0]) == evaluate(p->opr.op[1]);
                case NEQ:
                    return evaluate(p->opr.op[0]) != evaluate(p->opr.op[1]);
            }
    }
    return 0;
}
