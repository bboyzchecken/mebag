'use strict'

/*
|--------------------------------------------------------------------------
| Routes
|--------------------------------------------------------------------------
|
| Http routes are entry points to your web application. You can create
| routes for different URL's and bind Controller actions to them.
|
| A complete guide on routing is available here.
| http://adonisjs.com/docs/4.1/routing
|
*/

/** @type {typeof import('@adonisjs/framework/src/Route/Manager')} */

const Route = use('Route')
const Database = use("Database");

Route.get("/", 'UserController.index');
Route.get("/event_detail_:event_id", 'UserController.event_detail');
Route.get("/register", 'UserController.register_page');
Route.get("/login", 'UserController.login_check');
Route.get("/account", 'UserController.account');
Route.get("/bedealer", 'UserController.bedealer_page');
Route.post("/bedealer_register", 'UserController.bedealer_register');
Route.get("/logout", 'UserController.logout');
Route.get("/allevent", 'UserController.all_events');
Route.get("/history", 'UserController.history');
Route.get("/accept_recive_:order_id", 'UserController.accept_recive');
Route.get("/reject_recive_:order_id", 'UserController.reject_recive');
Route.get("/payment_:order_id", 'UserController.payment_page');
Route.post("/payment", 'UserController.payment');
Route.get("/change_password", 'UserController.change_password_page');
Route.post("/login/check", 'UserController.login');
Route.post("/account/upload_image", 'UserController.upload_image');
Route.post("/account/edit_profile", 'UserController.edit_profile');
Route.post("/register/add", 'UserController.register');
Route.post("/add_cart", 'UserController.add_cart');
Route.post("/password_change", 'UserController.password_change');
Route.get("/checkout_:user_id", 'UserController.checkout');
//
Route.get("/check_session", 'UserController.check_session');
Route.get("/clear_cart", 'UserController.clear_cart');
Route.get("/del_session", 'UserController.del_session');
Route.get("/del_cart/:product_key", 'UserController.del_cart');
Route.get("/view_cart", 'UserController.view_cart');

///dealer
Route.get("/dealer", 'DealerController.index');
Route.post("/dealer/login", 'DealerController.login');
Route.get("/dealer/dashboard", 'DealerController.dashboard');
Route.get("/dealer/logout", 'DealerController.delaer_logout');
Route.get("/dealer/account", 'DealerController.account');
Route.post("/dealer/account_edit_intro", 'DealerController.edit_intro');
Route.get("/dealer/bank", 'DealerController.bank');
Route.get("/dealer/event", 'DealerController.event');
Route.get("/dealer/event_create", 'DealerController.event_create');
Route.get("/dealer/event_detail_:event_id", 'DealerController.event_detail');
Route.get("/dealer/event/delete/:event_id", 'DealerController.delete_event');
Route.get("/dealer/event_edit_:event_id", 'DealerController.event_edit');
Route.get("/dealer/accept/:order_id", 'DealerController.accept_order');
Route.get("/dealer/reject/:order_id", 'DealerController.reject_order');
Route.post("/dealer/event/edit/", 'DealerController.edit_event');
Route.post("/dealer/event/add", 'DealerController.add_event');
Route.get("/dealer/order", 'DealerController.order');
Route.get("/dealer/order_detail_:order_id", 'DealerController.order_detail');
Route.post("/dealer/add_track", 'DealerController.add_track');
Route.get("/dealer/bank", 'DealerController.bank');
Route.get("/dealer/card", 'DealerController.card');
Route.get("/dealer/wallet", 'DealerController.wallet');
////
Route.get("/dealer/product_event_:event_id", 'DealerController.product_select');
Route.get("/dealer/product_create_event_:event_id", 'DealerController.product_create');
Route.get("/dealer/product_edit_:product_id", 'DealerController.product_edit');
Route.post("/dealer/product/add", 'DealerController.add_product');
Route.post("/dealer/product/edit", 'DealerController.edit_product');
Route.get("/dealer/product_delete/:product_id", 'DealerController.delete_product');
////

Route.get("/admin", 'AdminController.login_page');
Route.post("admin/login", 'AdminController.admin_login');
Route.get("/admin/logout", 'AdminController.admin_logout');
Route.get("/admin/dashboard", 'AdminController.dashboard');
Route.get("/admin/create_admin", 'AdminController.create_page');
Route.get("/admin/managedealer", 'AdminController.managedealer_page');
Route.get("/admin/bedealer_detail_:id", 'AdminController.bedealer_detail');
Route.get("/admin/tranfer", 'AdminController.tranfer');
Route.get("/admin/balance", 'AdminController.balance');
Route.get("/admin/payment", 'AdminController.payment');
Route.get("/admin/payment_detail_:payment_id", 'AdminController.payment_detail');
Route.get("/admin/order_detail_:order_id", 'AdminController.order_detail');
Route.get("/admin/accept_payment_:payment_id", 'AdminController.accept_payment');
Route.get("/admin/reject_payment_:payment_id", 'AdminController.reject_payment');
Route.get("/admin/accept_dealer_:user_id", 'AdminController.accept_dealer');
Route.get("/admin/reject_dealer_:user_id", 'AdminController.reject_dealer');
Route.get("/admin/receipt_upload_:user_id", 'AdminController.receipt_upload');
Route.get("/admin/tranfer_date", 'AdminController.tranfer_date');
Route.post("/admin/tranfer_date", 'AdminController.tranfer_date_post');
Route.get("/admin/tranfer_date_history", 'AdminController.tranfer_date_history');
/* Route.get("/admin/add_admin", 'AdminController.add_admin'); */
Route.post("/admin/add_tranfer", 'AdminController.add_tranfer');
Route.post("/admin/edit_tranfer", 'AdminController.edit_tranfer');
Route.get("/admin/accept_tranfer_:user_id", 'AdminController.accept_tranfer');