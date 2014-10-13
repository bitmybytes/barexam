-module(helloworld).

-behaviour(gen_server).

% API
-export([
    start_link/0,
    helloworld/0,
    helloworld/1
    ]).

% gen_server callbacks
-export([
    init/1,
    handle_call/3,
    handle_cast/2,
    handle_info/2,
    terminate/2,
    code_change/3
    ]).

-record(state, {}).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

helloworld() ->
    gen_server:call(?MODULE, helloworld).

helloworld(Name) ->
    gen_server:call(?MODULE, {helloworld, Name}).

%%% API implementation %%%

init([]) ->
    erlang:load_nif("priv/helloworld_drv", 0),
    {ok, #state{}}.

handle_call(helloworld, _From, State) ->
     helloworld_nif("World"),
    {reply, ok, State};

handle_call({helloworld, Name}, _From, State) ->
    helloworld_nif(Name),
    {reply, ok, State};

handle_call(_Msg, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_,_,_) ->
    ok.

% Error, if this function is executed at all
helloworld_nif(_Name) ->
    {error, nif_not_loaded}.
