-module(counter).

-behaviour(gen_server).
-export([start_link/0]).
%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2]).
-compile(export_all).


start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

get()       -> gen_server:call(?MODULE, {get}).
increment(Delta) -> gen_server:cast(?MODULE, {increment, Delta}).
increment_and_get(Delta)  -> gen_server:call(?MODULE, {increment_and_get, Delta}).


init([]) -> {ok, 0}.

handle_call({get}, _From, C) ->
    {reply, C, C};
handle_call({increment_and_get,Delta}, _From, C) ->
    NewC = C + Delta,
    {reply, NewC, NewC}.

handle_cast({increment, Delta}, C) -> {noreply, (C+Delta)}.
