'use strict'
const Database = use("Database");
const User = use("App/Models/User");
const { validate } = use('Validator');
const Hash = use('Hash');

class AdminController {
    async login_page({ view, response, session }) {
        if (session.get('admin')) {
            return response.redirect("/admin/dashboard");
        } else {
            return view.render('admins/login');
        }
    }

    //ระบบสมาชิก
    async create_page({ view, response, session }) {
        const users = await Database.from('users').where({
            'User_ID': session.get('User_ID')
        });
        return view.render('admins/create', {
            users: users
        })
    }

    async managedealer({ view, response, session }) {
        /*  const users = await Database.from('users').where({
             'User_ID': session.get('User_ID')
         }); */
        return view.render('admins/managedealer');
    }

    async tranfer({ view, response, session }) {
        /*  const users = await Database.from('users').where({
             'User_ID': session.get('User_ID')
         }); */
        return view.render('admins/tranfer');
    }

    async balance({ view, response, session }) {
        /*  const users = await Database.from('users').where({
             'User_ID': session.get('User_ID')
         }); */
        return view.render('admins/balance');
    }


}

module.exports = AdminController
