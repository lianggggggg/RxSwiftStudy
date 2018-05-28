//
//  AppStoreTodayViewController.swift
//  RxSwiftstudy
//
//  Created by admin on 2018/5/24.
//  Copyright © 2018年 MrLiang. All rights reserved.
//

import UIKit
import Then
import RxCocoa
import RxSwift
import RxDataSources
import NSObject_Rx
import MJRefresh
import Kingfisher

class AppStoreTodayViewController: UIViewController {

    lazy var headerView:TodayHeaderView = {
        let header = TodayHeaderView.loadFromNib()
        header.frame = CGRect.init(x: 0, y: 0, width: KScreenWidth, height: 115)
        return header
    }()
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.backgroundColor = .red
            tableView.register(cellType: TodayCell.self)
            tableView.rowHeight = TodayCell.cellHeight()
        }
    }
    
    let viewModel = ViewModel()
    
    let dataSource = RxTableViewSectionedReloadDataSource<sectionModel>(configureCell: {ds,tv,ip,item in UITableViewCell()
        
        let cell = tv.dequeueReusableCell(for: ip) as TodayCell
        cell.imgView.kf.setImage(with: URL.init(string: item.url))
        cell.titleLbl.text = item.url
        cell.contentLbl.text = item.url
        
        return cell
    })
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configView()
        
        bindView()
        
        self.tableView.mj_header.beginRefreshing()
 
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

extension AppStoreTodayViewController{
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.delegate = self

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func configView(){
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: 115))
        view.addSubview(headerView)
        self.tableView.tableHeaderView = view
    }
    
    func bindView(){
        
        //设置代理
        self.tableView.rx.setDelegate(self)
        
        //设置点击
//        self.tableView.rx.modelSelected(Model.self).subscribe(onNext: { (model) in
//
//            print(model)
//        })
        //OR
        self.tableView.rx.itemSelected.asObservable().subscribe(onNext: { (indexpaht) in
            print(indexpaht)
            
            let cell = self.tableView.cellForRow(at: indexpaht) as! TodayCell

            cell.transform = cell.transform.scaledBy(x: 0.9, y: 0.9)
            
            
            let todayDetailVC = loadStoryBoardVC("Main", "TodayDetailViewController") as! TodayDetailViewController
            
            self.navigationController?.pushViewController(todayDetailVC, animated: true)
            
            
        })
        
        let input = ViewModel.Input.init(category: .welfare)
        let output = self.viewModel.transfrom(input: input)
        
        output.sections.asDriver().drive(self.tableView.rx.items(dataSource: self.dataSource)).disposed(by: self.rx.disposeBag)
        
        //请求状态
        output.refreshStatus.asObservable().subscribe(onNext: { [weak self](status) in
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
            
            print(getWIFIName())
            
            output.requestCommond.onNext(true)
        })
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            output.requestCommond.onNext(false)
        })
    }
    
}

extension AppStoreTodayViewController:UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning{
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    
    //设置动画世界
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let cell = self.tableView.cellForRow(at: self.tableView.indexPathForSelectedRow!) as! TodayCell

        let toVC = transitionContext.viewController(forKey: .to)  //  跳转后的页面
        let toView = (toVC as! TodayDetailViewController).headerImageView
        let fromView = cell.backView

        let containerView = transitionContext.containerView
        let snapShotView = UIImageView.init(image: cell.imgView.image)

        snapShotView.frame = containerView.convert(fromView!.frame, to: fromView?.superview)

        fromView?.isHidden = true

        toVC?.view.frame = transitionContext.finalFrame(for: toVC!)
        toVC?.view.alpha = 0
        toView.isHidden = true
        
        let titleLbl = UILabel.init(frame: CGRect.init(x: 15, y: 20, width: KScreenWidth - 30, height: 30))
        titleLbl.font = UIFont.systemFont(ofSize: 25)
        titleLbl.textColor = .white
        titleLbl.text = cell.titleLbl.text
        
        let contentLbl = UILabel.init(frame: CGRect.init(x: 15, y: (KScreenWidth - 40)*1.3 - 40, width: KScreenWidth - 44, height: 15))
        contentLbl.textColor = .white
        contentLbl.font = UIFont.systemFont(ofSize: 15)
        contentLbl.alpha = 0.5
        contentLbl.text = cell.contentLbl.text
        
        snapShotView.addSubview(titleLbl)
        snapShotView.addSubview(contentLbl)
        
        containerView.addSubview((toVC?.view)!)
        containerView.addSubview(snapShotView)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            
            containerView.layoutIfNeeded()
            toVC?.view.alpha = 1.0
            
            let tabBar = self.tabBarController?.tabBar
            
            
            
            
        }) { (finished) in
            
        }
        
        
    }
    
    
}

extension AppStoreTodayViewController:UITableViewDelegate{
    //即将高亮
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        
        let cell = self.tableView.cellForRow(at: indexPath) as! TodayCell
        
        UIView.animate(withDuration: 0.2) {
            cell.transform = cell.transform.scaledBy(x: 0.9, y: 0.9)
        }
        return true
    }
    //结束高亮
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
        let cell = self.tableView.cellForRow(at: indexPath) as! TodayCell
        cell.transform = cell.transform.scaledBy(x: 1/0.9, y: 1/0.9)
        
    }
}

