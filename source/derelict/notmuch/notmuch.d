module derelict.notmuch.notmuch;

version (Derelict_Static) version = DerelictNotMuch_Static;

version (DerelictNotMuch_Static)
	public import derelict.notmuch.statfun;
else
	public import derelict.notmuch.dynload;
