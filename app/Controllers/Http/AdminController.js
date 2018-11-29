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

    async admin_login({ view, response, session }) {
        return response.redirect("/admin/dashboard");
    }

    async admin_logout({ view, response, session }) {
        return response.redirect("/admin/");
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

    async dashboard({ view, response, session }) {
        return view.render('admins/dashboard');

    }

    async tranfer({ view, response, session }) {
        return view.render('admins/tranfer');
    }

    async balance({ view, response, session }) {
        return view.render('admins/balance');
    }

    async managedealer_page({ view, response, session }) {
        const users_wait = await Database.from('users').where({
            'User_Permission': 3
        });
        //return users_wait;
        return view.render('admins/managedealer', {
            users_wait: users_wait,
        });
    }
    async bedealer_detail({ view, response, session ,params}) {
        const user_bedealer = await params.id;
        const users_wait_detail = await Database.from('users').where({
            'User_ID':user_bedealer 
        });
        //return users_wait;
        return view.render('admins/bedealer_detail', {
            users_detail: users_wait_detail,
        });
    }
}

module.exports = AdminController
