use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'            => 'Digest::JHash',
    'VERSION_FROM'    => 'JHash.pm',
    'PREREQ_PM'       => {},
    'LIBS'            => [''], # e.g., '-lm'
    'DEFINE'          => '', # e.g., '-DHAVE_SOMETHING'
    # Insert -I. if you add *.h files later:
    'INC'             => '', # e.g., '-I/usr/include/other'
    # Un-comment this if you add C files to link with later:
    # 'OBJECT'        => '$(O_FILES)', # link all the C files too
);
