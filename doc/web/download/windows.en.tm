<TeXmacs|1.0.7.3>

<style|tmweb>

<\body>
  <tmweb-current|Download|Windows><tmweb-title|Installing <TeXmacs> under
  <name|Windows>|<tmweb-download-links>>

  In order to install <TeXmacs> under <name|Windows>, you have two options:

  <\enumerate>
    <item>Try <hlink|<name|Qt>-<TeXmacs>|#install>, our experimental native
    Windows port of <TeXmacs>, based on <name|Qt>.

    <item>Use a more <hlink|stable version of <TeXmacs>|cygwin.en.tm>, based
    on <name|Cygwin>.
  </enumerate>

  Developers may also be interested in <hlink|compiling <name|Qt>-<TeXmacs>
  from its sources on <name|Windows>|winqt.en.tm>.

  <section|Installation of <name|Qt>-<TeXmacs>><label|install>

  In order to install the <name|Qt>-based version of <TeXmacs> on Windows,
  you should:

  <\enumerate>
    <item>Download <hlink|<scm|texmacs-installer.exe>|ftp://ftp.texmacs.org/pub/TeXmacs/windows/qt/texmacs-installer.exe>
    (33Mb). If you don't have ftp access, then you may also
    <hlink|load|http://www.texmacs.org/Download/ftp/windows/qt/texmacs-installer.exe>
    this file from the web.

    <item>Execute the downloaded <verbatim|texmacs-installer.exe> and follow
    the installation instructions.

    <item>Click on the <TeXmacs> icon on your desktop in order to launch
    <TeXmacs>.

    <item>The first time you run <TeXmacs>, the application will crash.
    Subsequent runs should work.
  </enumerate>

  <section|Notes>

  <\itemize>
    <item>We are working on a version of <TeXmacs> which is completely
    independent from <TeX>/<LaTeX>. Currently, <TeXmacs> only depends on
    <name|Bib><TeX> for the compilation of bibliographies. If this feature is
    essential to you, and if you have a fast internet connection, then you
    may want to download and install <hlink|<name|Mik><TeX>|http://www.miktex.org/>.

    <item>If you installed <name|Mik><TeX> in addition to <TeXmacs>, then,
    due to the availability of some additional font templates, certain fonts
    may be generated automatically. This results in a<nbsp>significant
    slow-down of <TeXmacs>. Don't panic: the fonts have to be generated only
    once. Subsequent runs of <TeXmacs> will be fast.

    <item>The current <math|\<beta\>>-version of <name|Qt>-<TeXmacs> for
    <name|Windows> does not yet support any plug-ins.
  </itemize>

  <tmdoc-copyright|1999--2010|Joris van der Hoeven|David Michel>

  <tmweb-license>
</body>

<\initial>
  <\collection>
    <associate|language|english>
  </collection>
</initial>