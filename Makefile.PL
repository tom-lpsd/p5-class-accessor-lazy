use inc::Module::Install;
name 'Class-Accessor-Lazy';
all_from 'lib/Class/Accessor/Lazy.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
