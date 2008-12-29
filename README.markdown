Cocoa Play
==========
Fuck if I know. Just following the <a title="Cocoa Programming for Mac OS X — Aaron Hillegass" href="http://bignerdranch.com/products.shtml">Hillegass book</a>.
Or rather, trying to. Cocoa and Objective-C are really hard for me, for
whatever reason.

Structure
---------
As I go through the Hillegass book, I'm making every change described in the
book (even those which you are not instructed to make). You should be able to
link any example of code in the Hillegass book here on GitHub in this
repository fairly easily.

I'm dropping a git tag every time I finish a chapter's instructions (even if
later chapters modify the code / project that was created), so you can see the
'completed state' of the project of any chapter by clicking on a given tag in
the 'tags' dropdown at the top of this project's GitHub page, and choosing a
chapter's tag.

I also tag standalone 'challenges' of the sort that Hillegass provides, when I
complete them. Remember that the challenges are freeform, and my
code/implementation is likely to differ from yours - in some cases, it doesn't
even look all that similar to the screenshots provided in the Hillegass book.

Interface Builder note
----------------------
It's worth noting that, due to my obsession with git, I'm manually policing
every change that Interface Builder makes to the XIB files in this repository,
so they aren't as trashy as most Cocoa project's diffs are. If you're like me,
and always ignore changes to those files in most repositories when browsing
commit histories, *please* don't ignore such changes here. I'm going to a lot
of work to make them human-readable and clean, so please go peruse them! Maybe
you will learn something about the structure of XIB files through doing so
(though I doubt it'll be as much as I've learned through said hand-editing!)

*Update:* I've taken the time to write up an extremely `(int|ext)ensive` blog
post about these topics, describing everything that I've learned, throughout
this project, about XIB files and how to git-version them safely/cleanly. If
you're at all considering working on a Cocoa project and storing that project
in a source control repository, you really should read it:

<http://blog.elliottcable.name/git_versioning_interface_builder_s_xib_files.xhtml>

On a related note, I occasionally make *extremely* granular commit streams to
this repository, going through a save/police/interactive-stage/commit process
after I drag any item, change any attribute, or do anything else, in the
Interface Builder. If you're following this repository, that may get annoying — I
apologize, but it's necessary for me to be able to break down exactly what
Interface Builder is doing in the future when I come back to learn from this
repository.