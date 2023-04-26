//
//  dashBoardViewController.swift
//  demoNotes
//
//  Created by Mohan K on 14/04/23.
//

import Foundation
import Firebase


class dashBoardVC: BaseVC {
    
    @IBOutlet weak var table: UITableView!
    
    let dashboardViewmodel = dashBoardViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(getUsersCollection), name: Notification.Name("UpdateData"), object: nil)
    }
    
    private func setupUI(){
        self.navigationItem.setHidesBackButton(true, animated: true)
        let btnLogout = UIBarButtonItem(title: "Logout", style: .plain,target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = btnLogout
        setupTableView()
        getUsersCollection()
    }
    
    @objc private func getUsersCollection() {
        ShowLoaderOnView()
        dashboardViewmodel.getUsersCollection {
            (success, msg) in
             HideLoaderOnView()
            DispatchQueue.main.async {
                if success {
                    self.table.reloadData()
                }
                else {
                    self.alert(message: msg)
                }
            }
        }
    }
    
    private func setupTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "NoteCell", bundle: nil), forCellReuseIdentifier: "NoteCell")
    }
    
    @objc func logout() {
        do {
            try Auth.auth().signOut()
            DLog("Sign out Sucessfully")
            self.navigationController?.popToRootViewController(animated: true)
        } catch {
            DLog("Sign out error")
        }
    }
}

extension dashBoardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dashboardViewmodel.arrUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as? NoteCell else {return UITableViewCell()}
        cell.title.text = dashboardViewmodel.arrUsers[indexPath.row].email
        cell.Content.text = dashboardViewmodel.arrUsers[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "updateProfileViewController") as? updateProfileViewController
        vc?.userInfo = dashboardViewmodel.arrUsers[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
