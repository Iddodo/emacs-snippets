This is where I&rsquo;ll put some Emacs snippets that I&rsquo;ve made that are interesting
enough to want to share with other people, but do not belong elsewhere.

I might develop some of these snippets further someday.


<a id="orgb4c9516"></a>

# org-school.el

Snippets intended to make my university life generally easier.


<a id="orgf8d7f88"></a>

## org-school-insert-folder-pdf-exam-checkboxes-under-subheading

![img](./media/checkboxes.gif)
  Under some heading for a course, prompt user for a directory
   in which they store its exams. Then create a subheading called \\&ldquo;EXAMS\\&rdquo;,
   under which all relevant exam PDF files will appear in the form of
   checkboxes.
   The idea was that I would use this to organize the methodology of
   solving exams.

This function is obviously very tailored to my use case, and currently
it does not offer any customization, and is not as clever as I would
like it to be, but it definitely does the trick.

I might make an effort to generalize the way it works in the future,
and might even expand the idea to generate more useful workflows.

