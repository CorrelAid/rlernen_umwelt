# Purpose: Setup the tutorial options for all lessons
tutorial_options(exercise.timelimit = 30)


options(tutorial.storage = list(
  save_object = function(...) { },
  get_object = function(...) NULL,
  get_objects = function(...) list(),
  remove_all_objects = function(...) { })
)