% DisplayPath.m ��ӡ·������
function DisplayPath(route, start, dest)
  % ��ӡ����������֮������·�� 
  % route : ·�ɱ� 
  % start : ���index
  % dest : �յ�index
  
  i = 1;
  
  while 1
    if(route(start, dest) ~= dest)
      fprintf('V%s -> ', num2str(start));
      start = route(start, dest);
    else
      fprintf('V%s -> ', num2str(start));
      fprintf('V%s\n', num2str(dest));
      break;
    end
  end

