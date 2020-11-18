FROM uwgac/topmed-master:2.6.0

# Install scripts
COPY *.sh /home/analyst/
RUN chmod a+x /home/analyst/*.sh
COPY *.R /home/analyst/
