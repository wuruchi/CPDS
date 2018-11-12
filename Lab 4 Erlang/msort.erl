-module(msort).
-compile(export_all).

sep(L,0) -> {[],L};
sep([H|T], N) -> {Lleft, Lright} = sep(T, N-1), {[H | Lleft], Lright}.

merge(L1,L2) -> lists:sort(L1 ++ L2).

ms([]) -> [];
ms([A]) -> [A];
ms(L) -> {L1,L2} = sep(L, length(L) div 2), LL = ms(L1), LR = ms(L2), merge(LL,LR).


rcvp(Pid) -> 
	receive
		{Pid, L} -> L
	end.

pms(L) -> 
	Pid = spawn(mergesort, p_ms, [self(), L]),
	rcvp(Pid).

p_ms(Pid, L) 
	when length(L) < 100 -> Pid ! {self(), ms(L)};

p_ms(Pid, L) -> {Lleft, Lright} = sep(L, length(L) div 2),
	Pid1 = spawn(mergesort, p_ms, [self(), Lleft]),
	Pid2 = spawn(mergesort, p_ms, [self(), Lright]),
	L1 = rcvp(Pid1),
	L2 = rcvp(Pid2),
	Pid ! {self(), merge(L1, L2)}.