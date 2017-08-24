#!/usr/bin/python

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
        r = urllib2.urlopen('http://localhost:{p}'.format(p=self.getConfig()['service']['port']))
        html = r.read()
        self.assertEqual(html, 'I am awesome\n')

    def testVersionSpecific(self):
        version = os.environ.get('VERSION')
        if version == '2.2':
            pass  # some version-specific test goes here

if __name__ == '__main__':
    main()
