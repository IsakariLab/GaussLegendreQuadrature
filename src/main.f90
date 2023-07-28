program main
  use module_gauss_legendre_quadrature
  implicit none

  ! 与えられた n に対し、 n 次の GL 公式を求める場合
  block 
    integer :: ng
    real(8),allocatable :: gz(:), we(:)

    ng=10
    allocate(gz(ng),we(ng))
    call assemble_gauss(ng,gz,we)
    write(*,*) ng
    write(*,*) gz
    write(*,*) we
    deallocate(gz,we)
  end block

  ! 与えられた n に対し、 0 から n 次の GL 公式を求める場合
  block 
    type(GaussLegendreQuadrature),allocatable :: glq(:)
    integer :: ig, ng
    
    ng=10
    
    allocate(glq(ng))
    do ig=1,ng
       glq%ng=ig
       allocate(glq(ig)%gz(ig),glq(ig)%we(ig))
       call assemble_gauss(glq(ig)%ng,glq(ig)%gz,glq(ig)%we)
       write(*,*) "---"
       write(*,*) "ng=", glq(ig)%ng
       write(*,*) glq(ig)%gz
       write(*,*) glq(ig)%we
    end do

    ! 掃除
    do ig=1,ng
       deallocate(glq(ig)%gz,glq(ig)%we)
    end do
    deallocate(glq)
    
  end block
     
end program main
