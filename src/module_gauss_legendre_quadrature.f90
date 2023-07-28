module module_gauss_legendre_quadrature
  use module_qlapack
  implicit none

  private
  public GaussLegendreQuadrature, assemble_gauss

  type :: GaussLegendreQuadrature
     integer :: ng
     real(8),allocatable :: gz(:)
     real(8),allocatable :: we(:)
  end type GaussLegendreQuadrature
  
contains
  !> ガウス積分の分点と重み
  !! \param ng 分点の数
  !! \param gz 分点の座標
  !! \param we 重み
  subroutine assemble_gauss(n,gz_,we_)
    integer,intent(in) :: n
    real(8),intent(out) :: gz_(n), we_(n)

    real(16) :: gz(n), we(n)
    
    !> 対称三重対角行列の対角成分
    real(16) :: td(n)

    !> 対称三重対角行列の非対角成分
    real(16) :: tl(n-1)

    !> 固有ベクトル
    complex(16) :: q(n,n)
    
    integer :: i, info
    real(16) :: work(2*n-2)
    
    td(:)=0.q0
    do i=1,n-1
       tl(i)=i/sqrt((2.q0*i-1.0q0)*(2.q0*i+1.q0))
    end do

    q(:,:)=cmplx(0.q0,0.q0,kind(1.q0))
    do i=1,n
       q(i,i)=cmplx(1.q0,0.q0,kind(1.q0))
    end do

    call qzsteqr("V",n,td,tl,q,n,work,info)

    do i=1,n
       gz(i)=td(i)
       we(i)=2.q0*(real(q(1,i))**2+aimag(q(1,i))**2)
    end do

    gz_=dble(gz)
    we_=dble(we)
    
  end subroutine assemble_gauss
  
end module module_gauss_legendre_quadrature
  
