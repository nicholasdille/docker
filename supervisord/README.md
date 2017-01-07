# Introduction

Example of Linux container using [supervisord](http://supervisord.org/) for signal handling with multiple processes

# Usage

Place a dedicated configuration file per daemon in `etc/supervisor.d`. Please refer to the the [supervisor documentation](http://supervisord.org/configuration.html#program-x-section-settings) how to create it.

This container already contains an example for dcron started in the foreground so supervisor can monitor the process. In the example, stdout and stderr are redirected to supervisord so that all messages are displayed on the console. Therefore, `docker logs` displays messages of supervisord and the cron daemon.
