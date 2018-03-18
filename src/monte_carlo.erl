%%%-------------------------------------------------------------------
%%% @author Isik Erhan
%%% @doc
%%% Calculation of PI number using Monte Carlo method
%%% @end
%%% Created : 17. Mar 2018 15:49
%%%-------------------------------------------------------------------
-module(monte_carlo).
-author("Isik Erhan").
-export([main/0,monte_carlo/1]).
-import(lists, [filter/2, map/2, sum/1, nth/2]).
-import(math, [sqrt/1, pow/2]).

main() ->
  % read the number of iterations from stdin
  {_, [NumberOfIterations]} = io:fread("Number of iterations: ", "~d"),
  % estimate the PI number using our monte_carlo function
  EstimatedPi = monte_carlo(NumberOfIterations),
  % print the result
  io:fwrite("Estimated PI number is ~w. Close enough?~n", [EstimatedPi]),
  PercentError = abs((EstimatedPi - math:pi()) / math:pi()) * 100,
  io:fwrite("%Error: ~w~n", [PercentError]).


monte_carlo(NumberOfIterations) ->
  % initialize a list of X, Y pairs having <NumberOfIterations> element where X and Y are in (-1.0, 1.0)
  MyList = [[rand:uniform() * 2 - 1.0, rand:uniform() * 2 - 1.0] || _ <- lists:duplicate(NumberOfIterations, 0)],
  sum(
    map(fun(_) -> 1 end,
      filter(fun(Pair) -> sqrt(pow(nth(1, Pair), 2) + pow(nth(2, Pair), 2)) < 1 end,
        MyList))) / NumberOfIterations * 4.
