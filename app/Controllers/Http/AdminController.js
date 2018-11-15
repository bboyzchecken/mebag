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
    async register_page({ view, response, session }) {
        const users = await Database.from('users').where({
            'User_ID': session.get('User_ID')
        });
        return view.render('users/register', {
            users: users
        })
    }
}

module.exports = AdminController
