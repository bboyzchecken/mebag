'use strict'
const Database = use("Database");
const User = use("App/Models/User");
const { validate } = use('Validator');
const Hash = use('Hash');
const Helpers = use('Helpers')
const Encryption = use('Encryption');
class AdminController {
    async login_page({ view, response, session }) {
        if (session.get('Admin_Email')) {
            return response.redirect("/admin/dashboard");
        } else {
            return view.render('admins/login');
        }
    }

    async admin_login({ view, response, session, request }) {
        let GETDATA = request.post();
        const admins = await Database.from('admins').where({
            'Admin_Email': GETDATA.email
        });

        if (admins != 0) {
            const password = await Hash.verify(GETDATA.password, admins[0].Admin_Password);
            if (password) {
                session.put('Admin_ID', admins[0].Admin_ID);
                session.put('Admin_Email', admins[0].Admin_Email);
                return response.redirect("/admin/dashboard");
            } else {
                return view.render('admins/login', { error: " รหัสผ่านไม่ถูกต้อง กรุณาตรวจสอบ" })
            }
        } else {
            return view.render('admins/login', { error: " โปรดตรวจสอบบัญชีผู้ใช้งานของท่าน " })
        }
    }

    async admin_logout({ view, response, session }) {
        session.forget('Admin_Email');
        session.forget('Admin_ID');
        return response.redirect("/admin");
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


        if (session.get('Admin_ID') && session.get('Admin_Email')) {
            const admins = await Database.from('admins').where({
                'Admin_Email': session.get('Admin_Email')
            });
            const balance_sum= await Database.from('balances').getSum('Balance_Get');
            const dealer_sum= await Database.from('users').where({
                User_Permission:1
            });
            const payment_sum= await Database.from('payments');
            const event_sum= await Database.from('events');
            return view.render('admins/dashboard', {
                admins: admins,
                balance_sum:balance_sum,
                dealer_sum:dealer_sum,
                payment_sum:payment_sum,
                event_sum:event_sum
            });

        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }
    }

    async tranfer({ view, response, session }) {
        if (session.get('Admin_ID') && session.get('Admin_Email')) {
            let tranfers = await Database.from('users').where('User_Wallet', '>=', 500)
            const admins = await Database.from('admins').where({
                'Admin_Email': session.get('Admin_Email')
            });

            return view.render('admins/tranfer', {
                tranfers: tranfers,
                admins: admins
            });

        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }


    }

    async balance({ view, response, session }) {
        if (session.get('Admin_ID') && session.get('Admin_Email')) {
            const admins = await Database.from('admins').where({
                'Admin_Email': session.get('Admin_Email')
            });
            const balances= await Database.from('balances');
            const balance_sum= await Database.from('balances').getSum('Balance_Get');
            
            return view.render('admins/balance', {
                admins: admins,
                balances:balances,
                balance_sum:balance_sum
            });

        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }


    }

    async managedealer_page({ view, response, session }) {

        if (session.get('Admin_ID') && session.get('Admin_Email')) {
            const admins = await Database.from('admins').where({
                'Admin_Email': session.get('Admin_Email')
            });
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
                admins: admins
            });
        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }

    }
    async bedealer_detail({ view, response, session, params }) {

        if (session.get('Admin_ID') && session.get('Admin_Email')) {
            const admins = await Database.from('admins').where({
                'Admin_Email': session.get('Admin_Email')
            });
            const user_bedealer = await params.id;
            const users_wait_detail = await Database.from('users').innerJoin('verifies', 'users.User_ID', 'verifies.User_ID').where({
                'users.User_ID': user_bedealer
            });
            //return users_wait;
            return view.render('admins/bedealer_detail', {
                users_detail: users_wait_detail,
                admins: admins
            });
        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }
    }
    async payment({ view, response, session }) {

        if (session.get('Admin_ID') && session.get('Admin_Email')) {
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
        if (session.get('Admin_ID') && session.get('Admin_Email')) {
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
        if (session.get('Admin_ID') && session.get('Admin_Email')) {

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
        if (session.get('Admin_ID') && session.get('Admin_Email')) {

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
        if (session.get('Admin_ID') && session.get('Admin_Email')) {
            const admins = await Database.from('admins').where({
                'Admin_Email': session.get('Admin_Email')
            });
            const orders_detail = await Database.from('orders').innerJoin('order_details', 'orders.Order_ID', 'order_details.Order_ID').innerJoin('events', 'orders.Event_ID', 'events.Event_ID').where({
                'orders.Order_ID ': order_id
            });
            const payment = await Database.from('payments').where({
                'Order_ID': order_id
            });

            return view.render('admins/order_detail', {
                order_detail: orders_detail,
                payment: payment,
                admins: admins
            })
        } else {
            return view.render('admins/login', { error: "  กรุณาล็อกอินเข้าสู่ระบบ " })
        }


    }
    async accept_dealer({ view, response, session, params }) {
        let user_id = params.user_id;
        if (session.get('Admin_ID') && session.get('Admin_Email')) {

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
        if (session.get('Admin_ID') && session.get('Admin_Email')) {

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
        if (session.get('Admin_ID') && session.get('Admin_Email')) {
            const admins = await Database.from('admins').where({
                'Admin_Email': session.get('Admin_Email')
            });
            let users = await Database.from('users').where({
                'User_ID': user_id
            });
            let check_tranfer = await Database.from('tranfers').where({
                User_ID: user_id
            })
            return view.render('admins/receipt_upload', {
                admins: admins,
                users: users,
                tranfer: check_tranfer
            })


        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }


    }
    async tranfer_date({ view, response, session, params }) {
        let user_id = params.user_id;
        if (session.get('Admin_ID') && session.get('Admin_Email')) {
            const admins = await Database.from('admins').where({
                'Admin_Email': session.get('Admin_Email')
            });
            let date = await Database.from('tranfer_date').orderBy('Date_ID', 'desc');
            return view.render('admins/tranfer_date', {
                date: date,
                admins: admins
            })


        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }


    }
    async tranfer_date_post({ view, response, session, request }) {
        let data = request.post();
        if (session.get('Admin_ID') && session.get('Admin_Email')) {

            let insert = await Database.table('tranfer_date').insert({
                Tranfer_Date: data.Tranfer_Date
            });
            if (insert) {
                session.flash({ success: ' สร้างวันโอน สำเร็จ ' })
                return response.redirect('back');
            } else {
                session.flash({ error: ' สร้างวันโอน ไม่สำเร็จ  กรุณาตรวจสอบ' })
                return response.redirect('back');
            }


        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }


    }
    async tranfer_date_history({ view, response, session, request }) {

        if (session.get('Admin_ID') && session.get('Admin_Email')) {
            let tranfer_date_history = await Database.from('tranfer_date').orderBy('Date_ID', 'DESC');
            const admins = await Database.from('admins').where({
                'Admin_Email': session.get('Admin_Email')
            });
            return view.render('admins/tranfer_date_history', {
                date: tranfer_date_history,
                admins: admins
            })

        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }


    }
    async add_tranfer({ view, response, session, request }) {
        let data = request.post();
        if (session.get('Admin_ID') && session.get('Admin_Email')) {
            const Tranfer_Receipt = request.file('Tranfer_Receipt', {
                types: ['image'],
                size: '2mb'
            })

            await Tranfer_Receipt.moveAll(Helpers.publicPath('assets/fileuploads/tranfers/'), (file) => {
                return {
                    name: session.get('User_ID') + "_" + Encryption.encrypt(file.fileName) + "." + `${file.subtype}`
                }
            })
            if (Tranfer_Receipt.movedAll()) {
                let insert = await Database.table('tranfers').insert({
                    User_ID: data.User_ID,
                    Tranfer_Receipt: Tranfer_Receipt['_files'][0].fileName,
                    Tranfer_BankNumber: data.Tranfer_BankNumber,
                    Tranfer_Time: data.Tranfer_Time,
                    Tranfer_Date: data.Tranfer_Date,
                    Tranfer_Amount: data.Tranfer_Amount,

                });
                if (insert) {
                    session.flash({ success: 'แจ้งโอนสำเร็จ' })
                    return response.redirect('/admin/tranfer');
                } else {
                    session.flash({ error: 'ไม่สามารถแจ้งโอนได้ กรุณาตรวจสอบ' })
                    return response.redirect('/admin/tranfer');
                }
            } else {
                session.flash({ error: Tranfer_Receipt.errors() })
                return response.redirect('/admin/tranfer');
            }

        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }


    }
    async edit_tranfer({ view, response, session, request }) {
        let data = request.post();
        if (session.get('Admin_ID') && session.get('Admin_Email')) {
            const Tranfer_Receipt = request.file('Tranfer_Receipt', {
                types: ['image'],
                size: '2mb'
            })

            await Tranfer_Receipt.moveAll(Helpers.publicPath('assets/fileuploads/tranfers/'), (file) => {
                return {
                    name: session.get('User_ID') + "_" + Encryption.encrypt(file.fileName) + "." + `${file.subtype}`
                }
            })
            if (Tranfer_Receipt.movedAll()) {
                let insert = await Database.table('tranfers').update({

                    Tranfer_Receipt: Tranfer_Receipt['_files'][0].fileName,
                    Tranfer_BankNumber: data.Tranfer_BankNumber,
                    Tranfer_Time: data.Tranfer_Time,
                    Tranfer_Date: data.Tranfer_Date,
                    Tranfer_Amount: data.Tranfer_Amount,

                }).where({
                    User_ID: data.User_ID,
                });
                if (insert) {
                    session.flash({ success: 'แก้ไขหลักฐานการแจ้งโอนสำเร็จ' })
                    return response.redirect('/admin/tranfer');
                } else {
                    session.flash({ error: 'ไม่สามารถแก้ไขแจ้งโอนได้ กรุณาตรวจสอบ' })
                    return response.redirect('/admin/tranfer');
                }
            } else {
                session.flash({ error: Tranfer_Receipt.errors() })
                return response.redirect('/admin/tranfer');
            }

        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }


    }
    async accept_tranfer({ view, response, session, request, params }) {
        let user_id = params.user_id;
        if (session.get('Admin_ID') && session.get('Admin_Email')) {

            let update = await Database.table('tranfers').update({
                Tranfer_Status: 1

            }).where({
                User_ID: user_id
            });
            if (update) {
                session.flash({ success: 'ยืนยันการแจ้งโอนเงินสำเร็จ' })
                return response.redirect('/admin/tranfer');
            } else {
                session.flash({ error: 'ไม่สามารถยืนยันแจ้งโอนได้ กรุณาตรวจสอบ' })
                return response.redirect('/admin/tranfer');
            }


        } else {
            return view.render('admins/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
            })
        }


    }
    /*   async add_admin({ view, response, session, request }) {
          let add = await Database.table("admins").insert({
              Admin_FirstName: "แอดมิน",
              Admin_LastName: "ใหญ่",
             
          
              Admin_Email:' admin@mebag.com',                  
              Admin_Permission: 1,
              Admin_Password: await Hash.make('1234'),
             
          });
          return response.redirect('/admin')
          if (GETDATA.User_Password.length > 6 && GETDATA.User_Password.length < 26 && GETDATA.User_Password.match(pattern_eng)) {
              if (GETDATA.User_Password == GETDATA.confirm_password) {
                  let add = await Database.table("admins").insert({
                      Admins_FirstName: GETDATA.User_FirstName,
                      Admins_LastName: GETDATA.User_LastName,
                      Admins_Sex: GETDATA.User_Sex,
                      Admins_BirthDay: GETDATA.User_BirthDay,
                      Admins_Tel: GETDATA.User_Tel,
                      Admins_Email: GETDATA.User_Email,                  
                      User_Address: GETDATA.User_Address,
                      User_Password: await Hash.make(GETDATA.confirm_password.trim()),
                      User_Permission: '0'
                  });
               }
          }
  
  
      } */
}

module.exports = AdminController
