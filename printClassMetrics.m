function [] = printClassMetrics (pred_val , yval,verbose)
  accuracy = mean(double(pred_val == yval));
  if (verbose)
    fprintf("|--> accuracy == %f  \n\n",accuracy*100);
  end 
end
