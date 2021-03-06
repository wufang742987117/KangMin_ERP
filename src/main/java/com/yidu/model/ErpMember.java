package com.yidu.model;

import java.math.BigDecimal;

public class ErpMember {
	private String memberId;

    private String memberName;

    private String memberSex;

    private String memberPhone;

    private BigDecimal memberNum;

    private String memberEmail;

    private String memberStarttime;

    private String memberValidate;

    private BigDecimal memberPizheko;

    private BigDecimal memberZheko;

    private String memberStauts;

    private String memberReamrk;
    

    public BigDecimal getMemberPizheko() {
		return memberPizheko;
	}

	public void setMemberPizheko(BigDecimal memberPizheko) {
		this.memberPizheko = memberPizheko;
	}

	public BigDecimal getMemberZheko() {
		return memberZheko;
	}

	public void setMemberZheko(BigDecimal memberZheko) {
		this.memberZheko = memberZheko;
	}

	public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId == null ? null : memberId.trim();
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName == null ? null : memberName.trim();
    }

    public String getMemberSex() {
        return memberSex;
    }

    public void setMemberSex(String memberSex) {
        this.memberSex = memberSex == null ? null : memberSex.trim();
    }

    public String getMemberPhone() {
        return memberPhone;
    }

    public void setMemberPhone(String memberPhone) {
        this.memberPhone = memberPhone == null ? null : memberPhone.trim();
    }

    public BigDecimal getMemberNum() {
        return memberNum;
    }

    public void setMemberNum(BigDecimal memberNum) {
        this.memberNum = memberNum;
    }

    public String getMemberEmail() {
        return memberEmail;
    }

    public void setMemberEmail(String memberEmail) {
        this.memberEmail = memberEmail == null ? null : memberEmail.trim();
    }

    public String getMemberStarttime() {
        return memberStarttime;
    }

    public void setMemberStarttime(String memberStarttime) {
        this.memberStarttime = memberStarttime == null ? null : memberStarttime.trim();
    }

    public String getMemberValidate() {
        return memberValidate;
    }

    public void setMemberValidate(String memberValidate) {
        this.memberValidate = memberValidate == null ? null : memberValidate.trim();
    }

    public String getMemberStauts() {
        return memberStauts;
    }

    public void setMemberStauts(String memberStauts) {
        this.memberStauts = memberStauts == null ? null : memberStauts.trim();
    }

    public String getMemberReamrk() {
        return memberReamrk;
    }

    public void setMemberReamrk(String memberReamrk) {
        this.memberReamrk = memberReamrk == null ? null : memberReamrk.trim();
    }
}