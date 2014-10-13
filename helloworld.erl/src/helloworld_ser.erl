-module(helloworld_ser).

-behaviour(gen_server).

%% public API's
-export([start_link/0, hello_world/0, hello_world/1]).

%% callback API's
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

%% public API's implementation
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

hello_world() ->
    gen_server:call(?MODULE, hello_world).

hello_world(Name) ->
    gen_server:call(?MODULE, {hello_world, Name}).

%% callback API's implementation
init([]) ->
    {ok, []}.

handle_call(hello_world, _From, State) ->
    io:format("Hello World!~n", []),
    {reply, ok, State};

handle_call({hello_world, Name}, _From, State) ->
    io:format("Hello ~s.~n", [Name]),
    {reply, ok, State};

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
