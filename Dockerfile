FROM searchathing/dc01

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

COPY crontab /var/spool/cron/crontabs/root
RUN chmod 600 /var/spool/cron/crontabs/root && chown root:crontab /var/spool/cron/crontabs/root
COPY mycmd.sh /root/.entrypoint

ENTRYPOINT /root/.entrypoint
