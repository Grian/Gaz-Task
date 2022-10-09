#
#===============================================================================
#
#         FILE: GazConfig
#
#  DESCRIPTION: Interface to project config
#
#       AUTHOR: Anatolij Grishaev (gg), grian@cpan.org
#      CREATED: 10/09/2022 07:59:32 AM
#===============================================================================

package GazConfig;
use 5.016;
use strict;
use warnings;
use autouse 'Data::Dumper' => 'Dumper';
use Const::Fast;
use Cwd qw(abs_path);
use File::Basename qw(basename dirname);
use DBI;
use Exporter 'import';
use YAML::Syck qw(LoadFile);

our @EXPORT_OK = qw(get_config get_dbh);

1 for $DB::single && $DB::single; # debug helper

sub get_config_path {
    my $this_file = ($INC{'GazConfig.pm'} //  __FILE__);
    state $default_config_dirpath = abs_path(join "/",  dirname((dirname($this_file))), 'config');
    return $default_config_dirpath;
}

sub get_config {
    my $config_path = get_config_path();
    my $maillog_file = join "/", $config_path, 'maillog.yaml';
    state $tmp = LoadFile($maillog_file);
    return $tmp;
}

our $dbh;
our $dbh_valid_till = -1;
sub get_dbh {
    if ($dbh && $dbh_valid_till < time()) {
        return $dbh;
    }

    my $config = get_config();
    my $dbh_conf;
    $dbh_conf = $config;
    $dbh_conf = $dbh_conf->{$_} for qw/dbh connection /;
    $dbh_conf //= die "get_config: missing key dbh->connection";
    my $options = { RaiseError => 1, PrintError => 1, PrintWarn => 1, $dbh_conf->%* };
    $dbh = DBI->connect(
        $dbh_conf->{schema},
        $dbh_conf->{user},
        $dbh_conf->{pass},
    $options ) or die "dbi:connect: " . DBI->errstr;
    return $dbh;
}

sub main {
    print Dumper(get_config());
    get_dbh();
}

main() if !caller;

1;
 

