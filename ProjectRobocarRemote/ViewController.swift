//
//  ViewController.swift
//  ProjectRobocarRemote
//
//  Created by 何元会 on 2018/4/29.
//  Copyright © 2018年 Robocar. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var btnConnectDev: UIButton!
    @IBOutlet weak var btnAddDev: UIButton!
    @IBOutlet weak var btnEditDev: UIButton!
    @IBOutlet weak var btnDeleteDev: UIButton!
    
    var sock:SocketClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red:0.37, green:0.04, blue:0.72, alpha:1.0)
        self.view.backgroundColor = UIColor(red:0.20, green:0.05, blue:0.40, alpha:1.0)
        
        let sock = SocketClient()
        //sock.connect(url: "http://localhost", port: 8901)
        sock.connect(url: "http://192.168.1.105", port: 8901)
        
        drawLineButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        print(self.view.frame.size)
    }
    
    func drawLineButtons() -> Void {
        
        let bsize:CGFloat = 90
        let vwidth:CGFloat = self.view.frame.width
        let vheight:CGFloat = self.view.frame.height
        
        
        let bcenter11 = CGPoint(x:20+bsize/2, y:120)
        let bcenter12 = CGPoint(x:vwidth-20-bsize/2, y:120)
        draw_line(start: bcenter11, end: bcenter12, lineWidth: 4)
        draw_button(title:"Head Ctrl", center: bcenter11, size:bsize, tag:100)
        draw_button(title:"Hand Ctrl", center: bcenter12, size: bsize, tag:101)
        
        
        let bspace:CGFloat = min(vwidth,vheight) - bsize - 40
        let bcenter21 = CGPoint(x:vwidth/2.0, y:vheight*3.0/10.0)
        let bcenter22 = CGPoint(x:bcenter21.x-bspace/2, y:bcenter21.y+bspace/2)
        let bcenter23 = CGPoint(x:bcenter21.x+bspace/2, y:bcenter21.y+bspace/2)
        let bcenter24 = CGPoint(x:bcenter21.x, y:bcenter21.y+bspace)
        
        draw_line(start: bcenter21, end: bcenter22, lineWidth: 4)
        draw_line(start: bcenter22, end: bcenter24, lineWidth: 4)
        draw_line(start: bcenter24, end: bcenter23, lineWidth: 4)
        draw_line(start: bcenter23, end: bcenter21, lineWidth: 4)
        
        draw_button(title:"Foreward", center: bcenter21, size:bsize, tag:102)
        draw_button(title:"Tune Left", center: bcenter22, size:bsize, tag:103)
        draw_button(title:"Tune Right", center: bcenter23, size:bsize, tag:104)
        draw_button(title:"Backward", center: bcenter24, size:bsize, tag:105)
    }
    
    func draw_button(title:String, center:CGPoint, size:CGFloat, tag:Int)
    {
        // 申明变量
        let btn = UIButton(frame:CGRect(x:center.x-size/2, y:center.y-size/2, width:size, height:size))
        // 设置背景颜色
        btn.backgroundColor = UIColor.orange
        //设置圆角长度
        btn.layer.cornerRadius = size/2
        //设置剪切 隐藏属性
        btn.layer.masksToBounds = true
        // 设置tag值
        btn.tag = tag
        // 添加按键事件处理函数
        btn.addTarget(self, action:#selector(buttonAction), for:UIControlEvents.touchUpInside)
        // 设置title
        btn.setTitle(title, for: UIControlState.normal)
        // 添加到view
        self.view.addSubview(btn)
    }
    
    func draw_line(start:CGPoint, end:CGPoint, lineWidth:CGFloat) -> Void {
        
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.gray.cgColor
        line.lineWidth = lineWidth
        line.lineJoin = kCALineJoinRound
        self.view.layer.addSublayer(line)
    }
    
    @objc func buttonAction(sender:UIButton){
        switch sender.tag {
        case 100:
            print("Click button 1")
            break
        case 101:
            print("Click button 2")
            break
        case 102:
            print("Click button 3")
            break
        default:
            print("others")
            break
        }
    }
    
    func getTextHeight(textStr:String,font:UIFont,width:CGFloat) -> CGFloat {
        let normalText: NSString = textStr as NSString
        let size = CGSize(width:width,height:1000)
        let dic = NSDictionary(object: font, forKey: kCTFontAttributeName as! NSCopying)
        let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : AnyObject], context:nil).size
        return stringSize.height
    }
    
    func getTexWidth(textStr:String,font:UIFont,height:CGFloat) -> CGFloat {
        let normalText: NSString = textStr as NSString
        let size = CGSize(width:1000, height:height)
        let dic = NSDictionary(object: font, forKey: kCTFontAttributeName as! NSCopying)
        let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : AnyObject], context:nil).size
        return stringSize.width
    }
}

