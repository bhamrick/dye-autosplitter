## DYE AutoSplitter by ExtraTricky

To use this autosplitter, download LiveSplit.Dye.asl and add a
"Scriptable Auto Splitter" component to your LiveSplit layout pointing to
the file location.

Splits are determined either by your total pigment count or by defeating
a boss. For non-boss splits, the autosplitter assumes that you will be
getting 5 pigments during that split by default. If you are going to be
collecting a different number of pigments, put that number in parentheses
somewhere in the split name. For example: "Green 3 (4)" or "Red Challenges (10)".

Boss splits are detected by name. Currently you must use one of the following
split names exactly (not including quotes, case-sensitive):

* Purple: "Vultures", "Purple", "Purple Boss"
* Blue: "Ice Golem", "Blue", "Blue Boss"
* Green: "Slime King", "Green", "Green Boss"
* Red: "Inferno", "Red", "Red Boss"

The autosplitter uses these splits in order to track which of the four worlds
you are in, so all four splits need to be present in order to work properly.

If you run into problems with this autosplitter, please open an issue on this repository.
Alternatively, if you fix the problem yourself, please open a pull request so
that we can fix it for other people as well.
