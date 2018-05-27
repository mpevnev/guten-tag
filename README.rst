
Guten Tag, a tag management and viewing plugin
==============================================

This plugin pursues two somewhat unrelated goals. The first goal is to gain
more control over tag file placement, reducing clutter in the filesystem by
using only one tag file per project (especially if you're using something like
Easytags but do not want to have a single global tag file). The second goal is
to provide a way to browse project tag tree - not the current file, like
Tagbar, but the tags for a project as a whole.

The first goal is achieved simply by walking a directory tree up from the
current file until one of 'marker' files (by default, either a 'src' or a
'.git' directory), and storing tag file there. Options to control the process
(and disable it for specific directories, like '/usr') are provided, see
'options' file in the 'doc' directory.

For the second goal, there's presently just ``GutenTagOpenWindow`` command. No
default mapping is provided. It opens a window with the tag structure for the
project that includes the currently opened file. Each entry is prefixed with a
single-letter code - it's *kind*. Most are obvious, some are not - consult your
ctags documentation. At the moment, ``gd`` is mapped to a 'goto definition'
command, which only works if you've placed the cursor on a tag. Several options
to control appearance of the tag window are provided.
