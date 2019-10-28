 x:`::5001`::5002                                  / we will monitor these processes
 add x                                             / add processes to monitor
 system"t 1000"                                    / start the monitor
 del `::5001                                       / remove process from monitor

c:![`int$();`$()]                                  / (c)onnected: dict (integer handle)!(symbolic process handle)
d:`u#`$()                                          / (d)isconnected: unique list of symbolic process handles
t:flip`h`s`ts!"isp"$\:()                           / (t)able of (h)andles, (s)ymbolic handles, (ts)tamps

add:{d::`u#d union x;x;upd[];}                     / add processes under monitor
del:{d::`u#d where not d in x;upd[];}              / delete processes from monitor

.z.ts:{                                            / on timer event: try reconnect to each (d)isconnected process
 { if[h:@[hopen;x;0i];                             / if successfully opened the (h)andle ...
      t,:(h;x;.z.p);                               / record into (t)able the (h)andle, x - symbolic process handle, timestamp
      c[h]:x;del x;];} each d;}                    / insert into dict of (c)onnected processes and remove from disconnected
.z.pc:{t,:(0i;;.z.p) a:c x; c _:x; add a;}         / on port close event: add failed process' handle (x) to disconnected, record into (t); clean up from connected

.z.wo:{w::.z.w;upd[];}                             / on WebSocket open, register the frontend and display the state

upd:{                                              / push the state to the WebSocket connection handle
 o:([]process:d;status:`disconnected);             / output table: (d)isconnected processes first ...
 o,:([]process:value c;status:`connected);         / (c)onnected processes last
 neg[w] .j.j o;                                    / convert to JSON string and send to WebSocket handle
 }
