		$(document).ready(function() {
			$(document).on('change', 'tfoot input[type="checkbox"]',
					
					function() {
				var checkboxes = $('tbody input[type="checkbox"]');
				checkboxes.prop('checked',this.checked);
			});

				// 개별 체크박스 클릭 이벤트
				$(document).on('change', 'tbody input[type="checkbox"]',
								function() {
									var selectAllCheckbox = $('tfoot input[type="checkbox"]');
									selectAllCheckbox.prop('checked',
									$('tbody input[type="checkbox"]:checked').length === $('tbody input[type="checkbox"]').length);
								});
				$(document).on('click', '.write-btn', function() {
					redirectToEnrollForm('${type}');
				});
	
				function redirectToEnrollForm(type) {
					if (type === 'board') {
						window.location.href = '/enrollForm.bo';
					}
					if (type === 'inreview') {
						window.location.href = '/enrollForm.in';
					}
					if (type === 'find') {
						window.location.href = '/enrollForm.fi'
					}
				}

					// 삭제 버튼 클릭 이벤트
					$(document).on('click','button.delete-btn', function() {
									var checkedCheckboxes = $('tbody input[type="checkbox"]:checked');
									var deleteIds = [];

									checkedCheckboxes.each(function() {
										deleteIds.push($(this).data('id'));
										});

									if (deleteIds.length === 0) {
										alert("삭제할 게시글을 선택해주세요.");
										return;
									}

									var confirmation = confirm("게시글을 삭제하시겠습니까?");
									if (!confirmation) {
										return;
									}

										// 삭제 처리를 위한 Ajax 요청
						$.ajax({
							type : "POST",
							url : "/mypage/boardDelete",
							data : {
								ids : deleteIds.join(","),
								type : '${type}',
								
							},
							success : function(response) {
								if (response === 'Y') {
									toastr.success("게시글이 삭제 되었습니다.");

									deleteIds.forEach(function(id) {
												$("tr[data-id=" + id + "]").remove();
											});
									$('tfoot input[type="checkbox"]').prop('checked', false);

								} else {
									toastr.error("게시글 삭제에 실패했습니다.");
								}
							},
							error : function() {
								toastr.error("게시글 삭제에 실패했습니다.");
							}

						});
					});
	});