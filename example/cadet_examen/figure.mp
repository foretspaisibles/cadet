% Copyright © 2001–2015 Michael Grünewald
% All rights reserved.

%%% figure.mp

beginfig(1)
  numeric pi;
  numeric radian;
  pair p[];
  path c;

  pi := 3.14159265358979323846;
  radian := 180/pi;

  u := 24bp;
  a := 3u;
  b := 2u;

  %
  % Axes
  %

  draw (-(a+u),0)--(a+u,0);
  draw (0,-(b+u))--(0,b+u);

  label.rt(btex $x$ etex,(a+u,0));
  label.top(btex $y$ etex,(0,b+u));

  %
  % Figure
  %

  vardef cos primary x = (cosd(x*radian)) enddef;
  vardef sin primary x = (sind(x*radian)) enddef;

  theta := pi/6;

  c = fullcircle xscaled 2a yscaled 2b;
  circumference := 2pi/length(c);


  %p0 = point(theta/circumference) of c;
  %p1 = point((pi - theta)/circumference) of c;
  %p2 = point((pi + theta)/circumference) of c;
  %p3 = point((2pi - theta)/circumference) of c;

  p0 = (a*cos(theta),b*sin(theta));
  p1 = (-a*cos(theta),b*sin(theta));
  p2 = (-a*cos(theta),-b*sin(theta));
  p3 = (a*cos(theta),-b*sin(theta));

  draw c;


  dotlabel.urt(btex $A$ etex, p0);
  dotlabel.ulft(btex $B$ etex, p1);
  dotlabel.llft(btex $C$ etex, p2);
  dotlabel.lrt(btex $D$ etex, p3);

  draw p0 --- p1 --- p2 --- p3 --- p0;

  draw (0,0)--p0;

  draw subpath(0, theta/circumference) of c scaled 0.25;

  label.urt(btex $\theta$ etex, point(0) of c scaled 0.4);


endfig;

bye;
%%% End of file `figure.mp'
