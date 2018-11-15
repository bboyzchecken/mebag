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
Route.get("/logout", 'UserController.logout');
Route.post("/login/check", 'UserController.login');
Route.post("/register/add", 'UserController.register');
Route.post("/add_cart", 'UserController.add_cart');
Route.get("/check_session", 'UserController.check_session');
///dealer
Route.get("/dealer", 'DealerController.index');
Route.post("/dealer/login", 'DealerController.login');
Route.get("/dealer/dashboard", 'DealerController.dashboard');
Route.get("/dealer/account", 'DealerController.account');
Route.post("/dealer/account_edit_intro", 'DealerController.edit_intro');
Route.get("/dealer/bank", 'DealerController.bank');
Route.get("/dealer/event", 'DealerController.event');
Route.get("/dealer/event_create", 'DealerController.event_create');
Route.get("/dealer/event_detail_:event_id", 'DealerController.event_detail');
Route.get("/dealer/event/delete/:event_id", 'DealerController.delete_event');
Route.get("/dealer/event_edit_:event_id", 'DealerController.event_edit');
Route.post("/dealer/event/edit/", 'DealerController.edit_event');
Route.post("/dealer/event/add", 'DealerController.add_event');
////
Route.get("/dealer/product_event_:event_id", 'DealerController.product_select');
Route.get("/dealer/product_create_event_:event_id", 'DealerController.product_create');
Route.get("/dealer/product_edit_:product_id", 'DealerController.product_edit');
Route.post("/dealer/product/add", 'DealerController.add_product');
Route.post("/dealer/product/edit", 'DealerController.edit_product');
Route.get("/dealer/product_delete/:product_id", 'DealerController.delete_product');
////

Route.get("/admin", 'AdminController.login_page');

