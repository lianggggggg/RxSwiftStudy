//
//  ViewController.swift
//  RxSwiftstudy
//
//  Created by admin on 2018/5/22.
//  Copyright © 2018年 MrLiang. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import NSObject_Rx
import MJRefresh

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.backgroundColor = .yellow
            tableView.register(cellType: ViewCell.self)
//            tableView.rowHeight = ViewCell.cellHeight()
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableViewAutomaticDimension
            
        }
    }
    
    let viewModel = ViewModel()
    
    let dataSource = RxTableViewSectionedReloadDataSource<sectionModel>(configureCell: {ds,tv,ip,item in UITableViewCell()
        
        let cell = tv.dequeueReusableCell(for: ip) as ViewCell
        cell.lbl.text = item.url
        return cell
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        bindView()
        
        tableView.mj_header.beginRefreshing()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewController{
    
    fileprivate func bindView(){

        //设置代理
        tableView.rx.setDelegate(self).disposed(by: self.rx.disposeBag)
        
        //MARK:tableview点击事件
        //tableview点击事件 -> 直接拿数据
        tableView.rx.modelSelected(Model.self).subscribe(onNext: { (model) in
            
            print(model)
            
        }).disposed(by: self.rx.disposeBag)
        
        //tableview点击事件 -> 通过indexpath
        tableView.rx.itemSelected.asObservable().subscribe(onNext: { (indexpath) in
         
            print(indexpath)
            
            print(try? self.dataSource.model(at: indexpath))
            
        }).disposed(by: self.rx.disposeBag)
        
        let input = ViewModel.VmInPut.init(category: .welfare)
        let output = self.viewModel.transfrom(input: input)
        
        output.sections.asDriver().drive(tableView.rx.items(dataSource: self.dataSource)).disposed(by: self.rx.disposeBag)

        //刷新状态的绑定
        output.refreshStatus.asObservable().subscribe(onNext: { [weak self] status in
            
            switch status{
                
            case .beingHeaderRefresh:
                self?.tableView.mj_header.beginRefreshing()
            case .endHeaderRefresh:
                self?.tableView.mj_header.endRefreshing()
            case .beingFooterRefresh:
                self?.tableView.mj_footer.beginRefreshing()
            case .endFooterRefresh:
                self?.tableView.mj_footer.endRefreshing()
            case .noMoreData:
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
            default :
                break
            }
            
        }).disposed(by: self.rx.disposeBag)
        
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            output.requestCommond.onNext(true)
        })
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            output.requestCommond.onNext(false)
        })
        
    }
    
}

extension ViewController:UITableViewDelegate{
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        let model = try! self.dataSource.model(at: indexPath) as! Model
//
//        print(model.url)
//
//
//
//
//        return 60
//    }
    
}


