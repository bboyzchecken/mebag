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
        session.put('Admin_ID', 'test');
        session.put('Admin_Emanil', 'test');
        return response.redirect("/admin/dashboard");
    }

    async admin_logout({ view, response, session }) {
        session.forget('Admin_Emanil');
        session.forget('Admin_ID');
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
        if (session.get('Admin_ID') && session.get('Admin_Emanil')) {
            let tranfers = await Database.from('users').where('User_Wallet', '>=', 500)

            return view.render('admins/tranfer', {
                tranfers: tranfers
            });

        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }


    }

    async balance({ view, response, session }) {
        return view.render('admins/balance');
    }

    async managedealer_page({ view, response, session }) {
        const users_wait = await Database.from('users').where({
            'User_Permission': 3
        });
        const users_accept = await Database.from('users').where({
            'User_Permission': 1
        });
        const users_reject = await Database.from('users').where({
            'User_Permission': 2
        });

        //return users_wait;
        return view.render('admins/managedealer', {
            users_wait: users_wait,
            users_accept: users_accept,
            users_reject: users_reject,
        });
    }
    async bedealer_detail({ view, response, session, params }) {
        const user_bedealer = await params.id;
        const users_wait_detail = await Database.from('users').innerJoin('verifies', 'users.User_ID', 'verifies.User_ID').where({
            'users.User_ID': user_bedealer
        });
        //return users_wait;
        return view.render('admins/bedealer_detail', {
            users_detail: users_wait_detail,
        });
    }
    async payment({ view, response, session }) {

        if (session.get('Admin_ID') && session.get('Admin_Emanil')) {
            const admins = await Database.from('admins').where({
                'Admin_ID': session.get('Admin_ID')
            });
            const payments = await Database.from('payments').innerJoin('orders', 'orders.Order_ID', 'payments.Order_ID').innerJoin('users', 'users.User_ID', 'payments.Payment_Whose').where({
                Payment_Status: '0'
            });
            const payments_accept = await Database.from('payments').innerJoin('orders', 'orders.Order_ID', 'payments.Order_ID').innerJoin('users', 'users.User_ID', 'payments.Payment_Whose').where({
                Payment_Status: 'accept'
            });
            const payments_reject = await Database.from('payments').innerJoin('orders', 'orders.Order_ID', 'payments.Order_ID').innerJoin('users', 'users.User_ID', 'payments.Payment_Whose').where({
                Payment_Status: 'reject'
            });
            return view.render('admins/payment', {
                admins: admins,
                payments: payments,
                payments_accept: payments_accept,
                payments_reject: payments_reject
            });
        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }

    }
    async payment_detail({ view, response, session, params }) {
        let payment_id = params.payment_id;
        if (session.get('Admin_ID') && session.get('Admin_Emanil')) {
            const admins = await Database.from('admins').where({
                'Admin_ID': session.get('Admin_ID')
            });
            const payments = await Database.from('payments').innerJoin('orders', 'orders.Order_ID', 'payments.Order_ID').innerJoin('users', 'users.User_ID', 'payments.Payment_Whose').where({
                Payment_ID: payment_id
            });
            const payments_accept = await Database.from('payments').innerJoin('orders', 'orders.Order_ID', 'payments.Order_ID').innerJoin('users', 'users.User_ID', 'payments.Payment_Whose').where({
                Payment_ID: payment_id
            });
            const payments_reject = await Database.from('payments').innerJoin('orders', 'orders.Order_ID', 'payments.Order_ID').innerJoin('users', 'users.User_ID', 'payments.Payment_Whose').where({
                Payment_ID: payment_id
            });
            return view.render('admins/payment_detail', {
                admins: admins,
                payments: payments
            });
        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }

    }
    async accept_payment({ view, response, session, params }) {
        let payment_id = params.payment_id;
        if (session.get('Admin_ID') && session.get('Admin_Emanil')) {

            //code here
            let payment_update = await Database.table('payments').where('Payment_ID', payment_id).update({
                Payment_Status: 'accept'
            });
            if (payment_update) {
                let order_update = await Database.table('orders').where('Order_Payment', payment_id).update({
                    Order_Status: 'paid'
                });
                if (order_update) {
                    session.flash({ success: ' ยืนยันรายการชำระเงิน สำเร็จ ' })
                    return response.redirect('back');
                } else {
                    session.flash({ error: ' ไม่สามารถทำรายการได้ โปรดตรวจสอบ ' })
                    return response.redirect('back');
                }
            } else {
                session.flash({ error: ' ไม่สามารถทำรายการได้ โปรดตรวจสอบ ' })
                return response.redirect('back');
            }

        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }

    }
    async reject_payment({ view, response, session, params }) {
        let payment_id = params.payment_id;
        if (session.get('Admin_ID') && session.get('Admin_Emanil')) {

            //code here
            let payment_update = await Database.table('payments').where('Payment_ID', payment_id).update({
                Payment_Status: 'reject'
            });
            if (payment_update) {
                let order_update = await Database.table('orders').where('Order_Payment', payment_id).update({
                    Order_Status: 'cancel'
                });
                if (order_update) {
                    session.flash({ success: ' ทำรายการ สำเร็จ ' })
                    return response.redirect('back');
                } else {
                    session.flash({ error: ' ไม่สามารถทำรายการได้ ออเดอร์ผิดพลาด โปรดตรวจสอบ ' })
                    return response.redirect('back');
                }
            } else {
                session.flash({ error: ' ไม่สามารถทำรายการได้ โปรดตรวจสอบ ' })
                return response.redirect('back');
            }

        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }

    }
    async order_detail({ view, params, response, session }) {
        let order_id = params.order_id;
        if (session.get('Admin_ID') && session.get('Admin_Emanil')) {

            const orders_detail = await Database.from('orders').innerJoin('order_details', 'orders.Order_ID', 'order_details.Order_ID').innerJoin('events', 'orders.Event_ID', 'events.Event_ID').where({
                'orders.Order_ID ': order_id
            });
            const payment = await Database.from('payments').where({
                'Order_ID': order_id
            });

            return view.render('admins/order_detail', {
                order_detail: orders_detail,
                payment: payment
            })
        } else {
            return view.render('admins/login', { error: "  กรุณาล็อกอินเข้าสู่ระบบ " })
        }


    }
    async accept_dealer({ view, response, session, params }) {
        let user_id = params.user_id;
        if (session.get('Admin_ID') && session.get('Admin_Emanil')) {

            //code here
            let accept = await Database.table('users').where('User_ID', user_id).update({
                User_Permission: 1
            });
            if (accept) {
                session.flash({ success: ' ยืนยันตัวตนผู้รับหิ้วสำเร็จ ' })
                return response.redirect('back');
            } else {
                session.flash({ error: ' ไม่สามารถทำรายการได้ โปรดตรวจสอบ ' })
                return response.redirect('back');
            }

        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }

    }
    async reject_dealer({ view, response, session, params }) {
        let user_id = params.user_id;
        if (session.get('Admin_ID') && session.get('Admin_Emanil')) {

            //code here
            let reject = await Database.table('users').where('User_ID', user_id).update({
                User_Permission: 2
            });
            if (reject) {
                session.flash({ success: ' ดำเนินการปฏิเสธผู้รับหิ้วเรียบร้อยแล้ว ' })
                return response.redirect('back');
            } else {
                session.flash({ error: ' ไม่สามารถทำรายการได้ โปรดตรวจสอบ ' })
                return response.redirect('back');
            }

        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }


    }
    async receipt_upload({ view, response, session, params }) {
        let user_id = params.user_id;
        if (session.get('Admin_ID') && session.get('Admin_Emanil')) {




        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }


    }
    async tranfer_date({ view, response, session, params }) {
        let user_id = params.user_id;
        if (session.get('Admin_ID') && session.get('Admin_Emanil')) {
            let date = await Database.from('tranfer_date').orderBy('Date_ID', 'desc');
            return view.render('admins/tranfer_date',{
                date:date
            })


        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }


    }
    async tranfer_date_post({ view, response, session, request }) {
        let data = request.post();
        if (session.get('Admin_ID') && session.get('Admin_Emanil')) {
           
            let insert = await Database.table('tranfer_date').insert({
                Tranfer_Date : data.Tranfer_Date
            });
            if(insert){
                session.flash({ success: ' สร้างวันโอน สำเร็จ ' })
                return response.redirect('back');
            }else{
                session.flash({ error: ' สร้างวันโอน ไม่สำเร็จ  กรุณาตรวจสอบ' })
                return response.redirect('back');
            }


        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }


    }
}

module.exports = AdminController
