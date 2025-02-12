#!/bin/bash -x

export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk.x86_64/jre
HADOOP_HOME=/usr/hdp/2.3.2.0-2950/hadoop
HADOOP=$HADOOP_HOME/bin/hadoop
CURDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DATADIR=$CURDIR/data
DYNDATADIR=$CURDIR/dynamic_data
UPLOADCMD="${HADOOP} fs -put"

mkdir -p $DYNDATADIR

python ${CURDIR}/create_data.py 5000 regression > ${DYNDATADIR}/regression.txt
python ${CURDIR}/create_data.py 5000 time > ${DYNDATADIR}/time.txt
python ${CURDIR}/create_data.py 5000 timestamp > ${DYNDATADIR}/timestamp.txt
python ${CURDIR}/create_data.py 5000 date > ${DATADIR}/date.txt
python ${CURDIR}/create_data.py 5000 bigint > ${DYNDATADIR}/bigint.txt
python ${CURDIR}/create_data.py 5000 int > ${DYNDATADIR}/int.txt
python ${CURDIR}/create_data.py 5000 smallint > ${DYNDATADIR}/smallint.txt
python ${CURDIR}/create_data.py 5000 real > ${DYNDATADIR}/real.txt
python ${CURDIR}/create_data.py 5000 float > ${DYNDATADIR}/float.txt
python ${CURDIR}/create_data.py 5000 boolean > ${DYNDATADIR}/boolean.txt
python ${CURDIR}/create_data.py 5000 varchar > ${DYNDATADIR}/varchar.txt
python ${CURDIR}/create_data.py 5000 bpchar > ${DYNDATADIR}/bpchar.txt
python ${CURDIR}/create_data.py 5000 numeric > ${DYNDATADIR}/numeric.txt
python ${CURDIR}/create_data.py 5000 text > ${DYNDATADIR}/text.txt
python ${CURDIR}/create_data.py 5000 all > ${DYNDATADIR}/all.txt
python ${CURDIR}/create_data.py 10000000 regression > ${DYNDATADIR}/random_with_seed_1.largetxt
python ${CURDIR}/create_data.py 100000 all > ${DYNDATADIR}/all_20.txt
python ${CURDIR}/create_data.py 500000 all > ${DYNDATADIR}/all_100.txt
sed 's/bigint/text/g' ${DYNDATADIR}/bigint.txt > ${DYNDATADIR}/bigint_text.txt

export HADOOP_USER_NAME=hdfs
$HADOOP fs -mkdir /plaintext/
$HADOOP fs -mkdir /extwrite/
${UPLOADCMD} $DATADIR/*  /plaintext/
$UPLOADCMD $DYNDATADIR/* /plaintext/
