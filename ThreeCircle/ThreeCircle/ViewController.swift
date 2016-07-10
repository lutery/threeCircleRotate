//
//  ViewController.swift
//  ThreeCircle
//
//  Created by 杨辉 on 16/7/4.
//  Copyright © 2016年 杨辉. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //左边的圆形
    var leftCirCle:UIView?;
    //中间的圆形
    var centerCirCle:UIView?;
    //右边的圆形
    var rightCirCle:UIView?
    //定时器
    var timer:Timer? = nil;
    //圆形半径
    let Radius = 30;
    
    static var playCount = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.addThreeCir();
        self.setTimer();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     * 设置定时起
     * 
     * @return Timer? 返回一个创建好的定时起
     */
    func setTimer() -> Timer?{
        if self.timer == nil {
            //swift中使用这个创建定时起，可以实现重复的功能
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(firstAnimation(_:)), userInfo: nil, repeats: true);
            //下面注释掉的语句无法实现重复的功能，只能够实现单次激活
//            self.timer = Timer(timeInterval: 3.0, target: self, selector: #selector(firstAnimation(_:)), userInfo: nil, repeats: true);
            self.timer?.fire();
        }
        
        return self.timer;
    }
    
    /**
     * 增加三个圆形
     */
    func addThreeCir(){
        //创建中间的圆形
        let centerCir = UIView(frame: CGRect(x: 0, y: 0, width: Radius, height: Radius));
        centerCir.center = self.view.center;
        centerCir.layer.cornerRadius = CGFloat(Radius) * CGFloat(0.5);
        centerCir.layer.masksToBounds = true;
        centerCir.backgroundColor = UIColor.orange();
        self.view.addSubview(centerCir);
        self.centerCirCle = centerCir;
        
        let centerPoint = centerCir.center;
        
        let leftCir = UIView(frame: CGRect(x: 0, y: 0, width: Radius, height: Radius));
        var leftCenter = leftCir.center;
        leftCenter.x = centerPoint.x - CGFloat(Radius);
        leftCenter.y = centerPoint.y;
        leftCir.center = leftCenter;
        leftCir.layer.cornerRadius = CGFloat(Radius) * CGFloat(0.5);
        leftCir.layer.masksToBounds = true;
        leftCir.backgroundColor = UIColor.orange();
        self.view.addSubview(leftCir);
        self.leftCirCle = leftCir;
        
        let rightCir = UIView(frame: CGRect(x: 0, y: 0, width: Radius, height: Radius));
        var rightCenter = rightCir.center;
        rightCenter.x = centerPoint.x + CGFloat(Radius);
        rightCenter.y = centerPoint.y;
        rightCir.center = rightCenter;
        rightCir.layer.cornerRadius = CGFloat(Radius) * 0.5;
        rightCir.layer.masksToBounds = true;
        rightCir.backgroundColor = UIColor.orange();
        self.view.addSubview(rightCir);
        self.rightCirCle = rightCir;
    }
    
    @objc func firstAnimation(_ timer:Timer){
        ViewController.playCount += 1;
        print(ViewController.playCount);
        
        UIView.animate(withDuration: 1.0, animations: {
            
            self.leftCirCle?.transform = CGAffineTransform(translationX: -(CGFloat)(self.Radius), y: 0);
            self.leftCirCle?.transform = CGAffineTransform(scaleX: 0.75, y: 0.75);
            self.rightCirCle?.transform = CGAffineTransform(translationX: CGFloat(self.Radius), y: 0);
            self.rightCirCle?.transform = CGAffineTransform(scaleX: 0.75, y: 0.75);
            self.centerCirCle?.transform = CGAffineTransform(scaleX: 0.75, y: 0.75);
            
            }, completion: {
                finished in
                UIView.animate(withDuration: 1.0, animations: {
                    self.leftCirCle?.transform = CGAffineTransform.identity;
                    self.rightCirCle?.transform = CGAffineTransform.identity;
                    self.centerCirCle?.transform = CGAffineTransform.identity;
                    self.secondAnimaition();
                })
        })
    }
    
    func secondAnimaition(){
        let leftCirPath = UIBezierPath();
        leftCirPath.addArc(withCenter: self.view.center, radius: CGFloat(self.Radius), startAngle: CGFloat(M_PI), endAngle: CGFloat(2.0) * CGFloat(M_PI) + CGFloat(2.0) * CGFloat(M_PI), clockwise: false);
        
        let leftCirAnimation = CAKeyframeAnimation(keyPath: "position");
        leftCirAnimation.path = leftCirPath.cgPath;
        leftCirAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear);
        leftCirAnimation.fillMode = kCAFillModeForwards;
        leftCirAnimation.isRemovedOnCompletion = true;
        leftCirAnimation.repeatCount = 2;
        leftCirAnimation.duration = 1.0;
        
        self.leftCirCle?.layer.add(leftCirAnimation, forKey: "cc");
        
        let rightCirPath = UIBezierPath();
        rightCirPath.addArc(withCenter: self.view.center, radius: CGFloat(self.Radius), startAngle: 0, endAngle: CGFloat(M_PI) + CGFloat(2) * CGFloat(M_PI), clockwise: false);
        let rightCirAnimation = CAKeyframeAnimation(keyPath: "position");
        rightCirAnimation.path = rightCirPath.cgPath;
        rightCirAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear);
        rightCirAnimation.fillMode = kCAFillModeForwards;
        rightCirAnimation.isRemovedOnCompletion = true;
        rightCirAnimation.repeatCount = 2;
        rightCirAnimation.duration = 1.0;
        
        self.rightCirCle?.layer.add(rightCirAnimation, forKey: "hh");
        
//        self.setTimer();
    }
}

