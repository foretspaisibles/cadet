# Cadet TeX — An experimental format for TeX

Cadet TeX started in 2001 as an experimental format whose general
design should follow milestones settled by plain TeX while adding some
higher level features common in other formats and missing in plain
TeX.

This experimental format aims at defining clean and extensible
programming paradigms.

## Installation guide

The installation procedure is based on the portable build system
[BSD Owl Scripts][bsdowl-home] written for BSD Make.

1. Verify that prerequisites are installed:
   - BSD Make
   - [BSD OWl][bsdowl-install]
   - GNU Autoconf
   - Noweb
   - Perl
   - TeX

2. Get the source, either by cloning the repository or by exploding a
   [distribution tarball](releases).

3. Optionally run `autoconf` to produce a configuration script. This
   is only required if the script is not already present.

4. Run `./configure`, you can choose the installation prefix with
   `--prefix`.

5. Run `make build`.

6. Finally run `make install`.

7. Edit the file `texmf.cnf`

Depending on how **BSD Make** is called on your system, you may need to
replace `make` by `bsdmake` or `bmake` in steps 5, 6, and 7.
The **GNU Make** program usually give up the ghost, croaking
`*** missing separator. Stop.` when you mistakingly use it instead of
**BSD Make**.

Step 7 requires that you can `su -` if you are not already `root`.


Michael Grünewald in Bonn, on April 11, 2014
