/* helloworld.c */
#include "erl_nif.h"
#include <stdio.h>

// Prototype
static ERL_NIF_TERM helloworld (ErlNifEnv* env, int argc,
                                          const ERL_NIF_TERM argv[]);

static ErlNifFunc nif_funcs[] =
{
    {"helloworld_nif", 1, helloworld}
};

static ERL_NIF_TERM helloworld (ErlNifEnv* env, int argc,
                                          const ERL_NIF_TERM argv[])
{
    unsigned int length = 0;
    enif_get_list_length(env, argv[0], &length);

    char *name = (char *)enif_alloc(++length);
    enif_get_string(env, argv[0], name, length, ERL_NIF_LATIN1);
    printf("Hello, %s!\n", name);
    enif_free(name);
    
    return enif_make_atom(env, "ok");
}

ERL_NIF_INIT(helloworld, nif_funcs, NULL, NULL, NULL, NULL);
