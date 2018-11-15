'use strict'

class TestController {
    test ({ response ,view }) {
        return view.render('welcome')
      }

    index ({ request, response }) {
        //
      }
}

module.exports = TestController
 