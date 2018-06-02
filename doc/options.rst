Options
=======

Guten Tag's options are just global variables. Set them in your .vimrc before
the plugin is loaded. Some can be redefined after the plugin is loaded and
still have some effect. If that's the case, it's mentioned.

Tag management options
======================

- ``guten_tag_forbidden_paths``: a list of regexps.

  If any of the regexps matches the name of the current file, the whole project
  tag file detection is disabled, and the tags option is set to 
  ``guten_tag_tags_when_forbidden``.

- ``guten_tag_markers``: a list of glob patterns.

  Controls project detection mechanism. If globbing of any of the patterns in a
  directory produces at least one file, the tags file will be put there.

- ``guten_tag_tags_files``: a list of filenames.

  Controls the name of the tags file. Any of the listed tag files will be used,
  but only one at a time!

- ``guten_tag_tags_when_forbidden``: a string.

  See ``guten_tag_forbidden_paths``.

Tag window settings
===================

- ``guten_tag_dense``: a boolean.

  If set to a true value, there will be no spaces between tags in the tags
  listing. Defaults to false. Can be set after the tag window is opened, run
  ``GutenTagOpenTagWindow`` again for the option to take effect.

- ``guten_tag_indent``: integer.

  Each nested tag will be indented by this amount relative to its parent.
  Can be set after the window is created, but needs refreshing for the option
  to take effect.

- ``guten_tag_shorten_path``: a boolean.

  If set to a true value, paths in the tag windows will be shortened as per
  ``pathshorten``. Defaults to false. Can be set after the tag window is
  opened, run ``GutenTagOpenTagWindow`` again for the option to take effect.

- ``guten_tag_starting_foldlevel``: integer in range 0-99.

  When a new tag window is opened, its foldlevel option will be set to this.
  Setting this variable to another value will affect *new* windows opened
  afterwards.

- ``guten_tag_split_style``: 'vertical' | 'horizontal'.

  If set to vertical, opening tag window will use vertical split, if to
  horizontal - horizontal split.

- ``guten_tag_window_height``: integer.

  The height of the tag window when splitting horizontally.

- ``guten_tag_window_width``: integer.

  The width of the tag window when splitting vertically.

Goto Definition settings
========================

- ``guten_tag_goto_split_style``: 'vertical' | 'horizontal'.

  Controls how a window opened by 'gd' mapping will be created.

- ``guten_tag_goto_position``: 'topleft' | 'botright' | 'aboveleft' | 'belowright'.

  Controls where a window opened by 'gd' mapping will be placed. See 
  ``:help topleft``, ``:help botright``, ``:help aboveleft`` and ``:help belowright``
  for details.
