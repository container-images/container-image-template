#!/usr/bin/python

import json
import urllib2
import os

from avocado import main
from avocado.core import exceptions
from moduleframework import module_framework


# THESE TESTS ARE EXECUTED ON HOST

class SanityCheck1(module_framework.AvocadoTest):
    """
    :avocado: enable
    """

    def test1(self):
        self.start()
        address = json.loads(
            self.runHost(
                "docker container inspect %s" % self.backend.docker_id
            ).stdout.strip())[0]["NetworkSettings"]["IPAddress"]
        r = urllib2.urlopen('http://{a}:{p}'.format(
            a=address,
            p=self.getConfig()['service']['port']))
        html = r.read()
        self.assertEqual(html, 'I am awesome\n')

    def testVersionSpecific(self):
        version = os.environ.get('VERSION')
        if version == '2.2':
            pass  # some version-specific test goes here

if __name__ == '__main__':
    main()
