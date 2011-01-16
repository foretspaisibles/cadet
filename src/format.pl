### format.pl -- Process the Format Specification

# Copyright (C) 2006, 2013 Michael Grünewald
# All rights reserved.
#
# This file is part of Bhrìd TeX.
#
# Bhrìd TeX is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Bhrìd TeX is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Bhrìd TeX.  If not, see <http://www.gnu.org/licenses/>.


use Getopt::Std;


my @extras = ( "image" );

#
# Format Specifications
#

sub format_spec_create {
    return {
	'Input_encoding' => '',
	'Drivers_support' => [],
	'Locales_support' => [],
	'Fontes_support' => [],
	'Setup_locale' => '',
	'Setup_paper' => '',
	'Setup_margin' => [],
	'Format' => '',
	'Format_name' => '',
	'Format_version' => '',
    };
}

sub format_spec_input {
    local *SPEC;
    my ($file, $format) = @_;
    my $answer = format_spec_create;
    my $entries = {};
    my $key = "";
    my $value = "";

    open SPEC, "<$file";
    while(<SPEC>) {
	chomp;
	m/^#/ && next;
	m/^[[:space:]]*$/ && next;
	if(m/^ /) {
	    $value = $value . $_;
	    next;
	}
	if(m/^([A-Za-z_]+):[[:space:]]*(.*)/) {
	    if($key) {
		$entries->{$key} = $value;
	    };
	    $key = $1;
	    $value = $2;
	};
	last if($key eq 'Format' && $value eq $format);
    };
    $entries->{$key} = $value;
    close SPEC;

    foreach $key (keys %$entries) {
	my @table;
	if($key =~ m/s_support$/ || $key eq "Setup_margin") {
	    @table = split /,[[:space:]]*/, $entries->{$key};
	    $answer->{$key} = \@table;
	} else {
	    $answer->{$key} = $entries->{$key};
        };
    }

    return $answer;
}

sub format_spec_output {
    my ($channel, $spec, $driver) = @_;

    my $format = $spec->{'Format'};
    my $inputenc = $spec->{'Input_encoding'};
    my $paper = $spec->{'Setup_paper'};
    my $name = $spec->{'Format_name'};
    my $version = $spec->{'Format_version'};

    print $channel "%%% $format\_$driver.tex -- Automatic dump\n";
    print $channel "\n";
    print $channel "\\input bhridcore\n";
    print $channel "\\input drv$driver\n";
    foreach my $extra (@extras) {
	print $channel "\\input $extra\n";
    };
    foreach my $font (@{$spec->{'Fontes_support'}}) {
	print $channel "\\input $font\n";
    };
    print $channel "\\input convent\n";
    print $channel "\\localesupport{%\n";
    foreach my $locale (@{$spec->{'Locales_support'}}) {
	$locale =~ m/(..)_(..)/
	    or die "bad locale: $locale";
	print $channel "  \\\\\{$1\}\{$2\}%\n";
    };
    print $channel "\}\n";

    #
    # Il est important de lire le fichier inputenc en dernier
    #

    print $channel "\\input $inputenc\n";
    $spec->{'Setup_locale'} =~ m/(..)_(..)/;
    print $channel "\\selectmainlocale\{$1\}\{$2\}\n";
    print $channel "\\setpaperformat{$paper}\n";
    print $channel "\\setmargin";
    foreach my $dimen (@{$spec->{'Setup_margin'}}) {
	print $channel "\{$dimen\}";
    };
    print $channel "\n";
    print $channel "\\normalfont\n";
    print $channel "\\normalsize\n";
    print $channel "\\selectlayoutmargin\n";
    print $channel "\\runhook\\formatdumphook\n";
    print $channel "\\let\\formatdumphook\\undefined\n";
    print $channel "\\def\\fmtname\{$name\}\n";
    print $channel "\\def\\fmtversion\{$version\}\n";
    print $channel "\\dump\n";
}

sub format_spec_list {
    my ($file) = @_;
    local *SPEC;
    open SPEC, "<$file";
    while(<SPEC>) {
	chomp;
	if(m/^Format:[[:space:]]*(\w*)/) {
	    print "$1\n";
	};
    };
    close SPEC;
}


#
# User interface
#

my %option = ();
getopts("m:f:d:l:", \%option);

if($option{l}) {
    format_spec_list $option{l};
    exit;
}

if($option{m} && $option{f} && $option{d}) {
    my $spec = format_spec_input $option{m}, $option{f};
    format_spec_output *STDOUT, $spec, $option{d};
    exit;
}

exit -1;

### End of file `format.pl'
