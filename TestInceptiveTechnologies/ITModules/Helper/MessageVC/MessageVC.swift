import UIKit


typealias MessageCompletionHandler = ((Int)->Void)

class MessageVC: UIViewController
{
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var msgContainerView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var msgView: UIView!
    @IBOutlet weak var lbl_msg: UILabel!
    @IBOutlet weak var btn_ok: UIButton!
    @IBOutlet weak var btnsVew: UIView!
    @IBOutlet weak var btnsStackView: UIStackView!
    
    var action:MessageCompletionHandler?
    
    var logoImg:String?
    var titleStr:String?
    var msgStr:String?
    var attMessage:NSAttributedString?
    var buttonTitles:[String]?
    
    var buttonArr:[UIButton] = [UIButton]()
    
    static func initVC(title:String? = nil, message:String? = nil, attMessage:NSAttributedString? = nil, buttonTitles:[String]? = nil, completionHandler:MessageCompletionHandler? = nil) -> MessageVC
    {
        let messageVC = MessageVC.initiate()
        messageVC.modalPresentationStyle = .overCurrentContext
        messageVC.modalTransitionStyle = .crossDissolve
        messageVC.definesPresentationContext = true
        messageVC.providesPresentationContextTransitionStyle = true
        
        messageVC.titleStr = title
        messageVC.msgStr = message
        messageVC.attMessage = attMessage
        messageVC.buttonTitles = buttonTitles
        
        messageVC.action = completionHandler
        return messageVC
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        
        self.bgView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        
        if titleStr != nil{
            self.lbl_title.text = titleStr
        }else{
            titleView.isHidden = true
        }
        
        if msgStr != nil{
            lbl_msg.text = msgStr
        }
        
        if attMessage != nil{
            lbl_msg.attributedText = attMessage
        }
        
        if buttonTitles != nil{
            if buttonTitles!.count > 0{
                if buttonTitles!.count == 1{
                    btn_ok.setTitle(buttonTitles![0], for: .normal)
                }else{
                    btn_ok.isHidden = true
                    if buttonTitles!.count == 2{
                        self.btnsStackView.axis = .horizontal
                        self.btnsStackView.alignment = .fill
                        self.btnsStackView.distribution = .fillEqually
                        self.btnsStackView.spacing = 16
                    }else{
                        btn_ok.isHidden = true
                        self.btnsStackView.axis = .vertical
                    }
                    
                    for (i, itme) in buttonTitles!.enumerated()
                    {
                        let btn = UIButton(configuration: .filled())
                        btn.setTitle(itme, for: .normal)
                        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
                        btn.setTitleColor(.white, for: .normal)
                        btn.configuration?.baseBackgroundColor = UIColor(named: "buttonColor")
                        btn.addTarget(self, action: #selector(self.btn_ok_action), for: .touchUpInside)
                        btn.tag = i
                        
                        buttonArr.append(btn)
                        
                        self.btnsStackView.addArrangedSubview(btn)
                        
                        if buttonTitles!.count == 2{
                            btn.translatesAutoresizingMaskIntoConstraints = false
                            let widthConstraint = NSLayoutConstraint(item: btn, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 80)
                            NSLayoutConstraint.activate([widthConstraint])
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 3, options: UIView.AnimationOptions(), animations: {
            
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            
            self.bgView.transform = CGAffineTransform.identity
        })
    }
    
    @IBAction func btn_ok_action(_ sender: UIButton)
    {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 3, options: UIView.AnimationOptions(), animations: {
            self.bgView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        }, completion: {
            finished in
            self.dismiss(animated: true) {
                self.action?(sender.tag)
            }
        })
    }
}

extension UIViewController {
    static func initiate() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            let bundle = Bundle(for: T.self)
            return T.init(nibName: String(describing: T.self), bundle: bundle)
        }
        return instantiateFromNib()
    }
}


